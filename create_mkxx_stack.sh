#!/bin/bash

[[ -n $DEBUG ]] && set -x

HEAT_STACK="${HEAT_STACK:-mk22_lab_advanced}"

if [[ ! -f template/${HEAT_STACK}.hot ]]; then
    echo "Error: no template/${HEAT_STACK}.hot file"
    exit 1
fi

git_url=""
git_branch=""
git_formula_branch=""

function usage {
    echo "Usage: $0 [-g] [-b] [-f]"
    echo ""
    echo "-g: Salt model Git URL (e.g. git@github.com:elemoine/mk-lab-salt-model.git)"
    echo "-b: Salt model Git branch"
    echo "-f: Formula branch (e.g. stacklight)"
    echo ""
}

while getopts ":g:b:f:" opt; do
    case $opt in
    g)
        git_url=$OPTARG
        ;;
    b)
        git_branch=$OPTARG
        ;;
    f)
        git_formula_branch=$OPTARG
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        usage $0
        exit 1
        ;;
    esac
done

stack_id=$(openstack stack list --column ID --format value --tags ${HEAT_STACK})
if [[ -n $stack_id ]]; then
    openstack stack delete --yes --wait $stack_id
fi

extra_options=""
if [[ -n $git_url ]]; then
    extra_options="--parameter reclass_address=$git_url"
fi
if [[ -n $git_branch ]]; then
    extra_options="$extra_options --parameter reclass_branch=$git_branch"
fi
if [[ -n $git_formula_branch ]]; then
    extra_options="$extra_options --parameter formula_branch=$git_formula_branch"
fi

openstack stack create \
    --parameter "key_value=$(cat ~/.ssh/id_rsa.pub)" \
    --environment env/${HEAT_STACK}/tcpisek.env \
    --template template/${HEAT_STACK}.hot \
    --tags ${HEAT_STACK} \
    $extra_options \
    "${HEAT_STACK}-$(date '+%Y-%m-%d')"

echo "Stacks:"
openstack stack list

IP=""
while [[ -z $IP ]]; do
    sleep 2
    IP=$(openstack floating ip list -c "Floating IP Address" -f value)
done
echo "Floating IPs:"
openstack floating ip list

stack_status=$(openstack stack list --column "Stack Status" --format value --tags ${HEAT_STACK})
while [[ $stack_status == "CREATE_IN_PROGRESS" ]]; do
    sleep 2
    stack_status=$(openstack stack list --column "Stack Status" --format value --tags ${HEAT_STACK})
done
echo "Stack creation complete."
