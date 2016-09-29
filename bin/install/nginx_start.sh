#!/bin/sh

host=(hk02 hk03 hk04)

for h in ${host[@]}; do
	scp -r /etc/php-fpm.d/ $h:/etc/
	scp -r /etc/nginx/ $h:/etc/
	ssh $h "service nginx restart"
	ssh $h "service php-fpm restart"
done
