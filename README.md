# MobSF-Dojo
MobSF DefectDojo

# Usage
- Clone Repository
- Create folder `target` and copy apk file
- Running test
```
TARGET_PATH='target/<target.apk>' DOJOKEY='<api_key>' DOJOIP='<ip:port>'  EGID='<Engagement_ID>' docker-compose up --build --exit-code-from scan
```
- Check PDF and JSON report under `output` folder
