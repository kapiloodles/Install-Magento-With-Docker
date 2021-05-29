version: '3'
services:
     web:
        build: ./images
        image: php-apache-magento
        container_name: php-apache
        restart: always
        volumes:
           - ./data/:/var/www/html
        ports:
           - "80:80"
        networks:
           - magento

     db:
       image: mysql:5.7
       container_name: mysql5.7
       restart: always
       environment:
           MYSQL_ROOT_PASSWORD: root
           MYSQL_DATABASE: exampledb
           MYSQL_USER: exampleuser
           MYSQL_PASSWORD: examplepass
       volumes:
            - ./db/db_data:/var/lib/mysql
       networks:
            - magento

     phpmyadmin:
        container_name: phpmyadmin
        restart: always
        image: phpmyadmin/phpmyadmin:latest
        ports:
          - "8080:80"
        depends_on:
          - db
        networks:
          - magento

networks:
    magento:
