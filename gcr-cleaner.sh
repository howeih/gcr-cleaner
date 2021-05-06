#/bin/bash
gcloud container images list --repository=${repository} | tail -n +2 | xargs -I {arg} sh -c "gcloud container images list-tags {arg} --filter='-tags:*' --format='get(digest)' --limit=unlimited --verbosity error| xargs -I {res} echo {res}+{arg}" | awk 'BEGIN {FS="+"} {print $2"@"$1}' | xargs gcloud container images delete --quiet || echo "Nothin to delete"
