# MobSF-Dojo
MobSF DefectDojo

# Usage
- Clone Repository
- Create folder `target` and copy apk file
- Running test
```
TARGET_PATH='target/<target.apk>' DOJOKEY='<api_key>' DOJOIP='<ip:port>'  PRODNAME='<Product_name>' docker-compose up --build --exit-code-from scan
```
- Check PDF and JSON report under `output` folder
