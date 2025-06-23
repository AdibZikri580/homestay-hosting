# Guna image Tomcat rasmi + JDK
FROM tomcat:9.0-jdk17

# Buang semua aplikasi default Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Salin fail WAR yang dibina dari NetBeans ke dalam folder webapps
COPY dist/HomestayFinder.war /usr/local/tomcat/webapps/ROOT.war

# Buka port 8080
EXPOSE 8080

# Arahan untuk jalankan Tomcat
CMD ["catalina.sh", "run"]
