if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <kubernetes container name>"
    exit 1
fi

container_name="k8s_$1"

container_id=""
until [[ -n $container_id ]]; do
    container_id=$(docker ps --filter "name=$container_name" --format "{{.ID}}")
    sleep 1
done

docker logs $container_id
echo $container_id

exit 0
