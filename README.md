# MobSF-Dojo
MobSF DefectDojo

# Usage
- Clone Repository
- cd to mobsf-dojo 
- copy apk file to scan folder
- Running test
```
TARGET_FILE='<target.apk>' DOJOKEY='<api_key>' DOJOURL='<url:port>'  PRODNAME='<Product_name>' docker-compose up --build --exit-code-from scan
```
- Check PDF and JSON report under `output` folder
