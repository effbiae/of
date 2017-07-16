rm -rI public tmpl.zip
curl http://cdn.openfin.co.s3-website-us-east-1.amazonaws.com/templates/OfTemplate.zip -otmpl.zip
unzip tmpl.zip
cd public
openfin -l -c app.json 
cd ..
