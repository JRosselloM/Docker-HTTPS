FROM httpd:2.4

RUN apt-get update && apt-get upgrade -y

# CREACION DE CERTIFICADO + LLAVE PRIVADA
RUN openssl req -x509 \
            -sha256 -days 356 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=demo.jrossello.com/C=ES/L=Balearic Islands" \
            -keyout server.key -out server.crt 
# COPIAR EL CERTIFICADO Y LA LLAVE DENTRO DE LA CARPETA CONF
# sed -i '/todo*/s/^#//g' ejemplo.sh
RUN cp server.crt server.key /usr/local/apache2/conf

# REEMPLAZAR TEXTO => QUITAR LOS HASTAGS PARA ELIMINAR LOS COMENTARIOS
RUN sed -i \
		-e '/ssl_module*/s/^#//g' \
		-e '/socache_shmcb_module*/s/^#//g' \
		-e '/httpd-ssl.conf*/s/^#//g' \
		conf/httpd.conf


EXPOSE 80
EXPOSE 443
