oc new-project ${RHT_OCP4_DEV_USER}-app-config

oc new-app --as-deployment-config --name myapp --build-env npm_config_registry=http://${RHT_OCP4_NEXUS_SERVER}/repository/nodejs nodejs:12~https://github.com/lenzch/DO288-apps#app-config --context-dir app-config

oc create cm myappconf --from-literal APP_MSG="Hello Dave"

oc create secret generic myappfilesec --from-file /home/student/DO288-apps/app-config/myapp.sec

oc set env dc/myapp --from cm/myappconf

oc set volume dc/myapp --add -t secret -m /opt/app-root/secure --name myappsec-vol --secret-name myappfilesec

oc delete project ${RHT_OCP4_DEV_USER}-app-config