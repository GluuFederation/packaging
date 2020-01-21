#!/bin/bash

build_root="./gluu-server"

VER=$1
INSTALL_VER=$2
CASA_SOURCE=$3
OXD_SOURCE=$4

DISTWEB="gluu-server/opt/dist/gluu"
COMMUNITY="gluu-server/install"
OPT="gluu-server/opt"
GLUU_ROOT="gluu-server"

INSTALL="master"
if [ -n "${INSTALL_VER}" ]; then
    INSTALL=$INSTALL_VER
fi

if [ -n "${VER}" ]; then
    #wget -nv http://ox.gluu.org/maven/org/gluu/oxidp/$VER/oxidp-$VER.war -O $DISTWEB/idp.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxshibbolethIdp/$VER/oxshibbolethIdp-$VER.war -O $DISTWEB/idp.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxtrust-server/$VER/oxtrust-server-$VER.war -O $DISTWEB/identity.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxauth-server/$VER/oxauth-server-$VER.war -O $DISTWEB/oxauth.war
    #wget -nv http://ox.gluu.org/maven/org/gluu/oxauth-rp/$VER/oxauth-rp-$VER.war -O $DIRWEB/oxauth-rp.war
    wget -nv http://ox.gluu.org/maven/org/gluu/oxShibbolethStatic/$VER/oxShibbolethStatic-$VER.jar -O $DISTWEB/shibboleth-idp.jar
    wget -nv http://ox.gluu.org/maven/org/gluu/oxShibbolethKeyGenerator/$VER/oxShibbolethKeyGenerator-$VER.jar -O $DISTWEB/idp3_cml_keygenerator.jar
#   wget -nv http://ox.gluu.org/maven/org/gluu/credmgr/credmgr/$VER/credmgr-$VER.war -O $DISTWEB/credmgr.war

    #rm -rf $COMMUNITY/community-edition-setup*
    #curl -LkSs https://codeload.github.com/GluuFederation/community-edition-setup/zip/$INSTALL -o $COMMUNITY/community-edition-setup.zip
    #unzip $COMMUNITY/community-edition-setup.zip -d $COMMUNITY
    #mv $COMMUNITY/community-edition-setup-$INSTALL $COMMUNITY/community-edition-setup
    #rm -rf $COMMUNITY/community-edition-setup.zip
    wget -nv https://github.com/GluuFederation/community-edition-setup/archive/$INSTALL.zip -O $DISTWEB/community-edition-setup.zip
    wget -nv https://raw.githubusercontent.com/GluuFederation/community-edition-setup/master/install.py -O gluu-server/opt/gluu/bin/install.py
    chmod +x gluu-server/opt/gluu/bin/install.py
    
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/gluu-serverd -O gluu-serverd
    chmod +x gluu-serverd
    wget https://ox.gluu.org/npm/passport/passport-4.1.0.tgz -O $DISTWEB/passport.tgz
    wget https://ox.gluu.org/npm/passport/passport-$INSTALL-node_modules.tar.gz -O $DISTWEB/passport-$INSTALL-node_modules.tar.gz
    wget -nv https://ox.gluu.org/maven/org/gluu/super-gluu-radius-server/$VER/super-gluu-radius-server-$VER-distribution.zip -O $DISTWEB/gluu-radius-libs.zip
    wget -nv https://ox.gluu.org/maven/org/gluu/super-gluu-radius-server/$VER/super-gluu-radius-server-$VER.jar -O $DISTWEB/super-gluu-radius-server.jar

    # systemd files for services
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/identity.service -O gluu-server/lib/systemd/system/identity.service 
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/opendj.service -O gluu-server/lib/systemd/system/opendj.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/oxauth-rp.service -O gluu-server/lib/systemd/system/oxauth-rp.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/oxauth.service -O gluu-server/lib/systemd/system/oxauth.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/passport.service -O gluu-server/lib/systemd/system/passport.service
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/systemd/idp.service -O gluu-server/lib/systemd/system/idp.service
    
    # Update script
    mkdir -p gluu-server/install/update
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/master/update/4.0.x/update_4.0.1.py -O gluu-server/install/update/update_4.0.1.py
    chmod +x gluu-server/install/update/update_4.0.1.py    
    
    # oxd files
    mkdir -p $DISTWEB/oxd-server/bin $DISTWEB/oxd-server/data $DISTWEB/oxd-server/lib $DISTWEB/oxd-server/conf
    wget https://raw.githubusercontent.com/GluuFederation/oxd/$INSTALL/oxd-server/src/main/bin/lsox.sh -O $DISTWEB/oxd-server/bin/lsox.sh
    wget https://raw.githubusercontent.com/GluuFederation/oxd/$INSTALL/oxd-server/src/main/bin/oxd-start.sh -O $DISTWEB/oxd-server/bin/oxd-start.sh
    wget https://raw.githubusercontent.com/GluuFederation/oxd/$INSTALL/debian/oxd-server.sh -O $DISTWEB/oxd-server/bin/oxd-server.sh
    
    wget https://github.com/GluuFederation/oxd/raw/$INSTALL/oxd-server/src/main/resources/oxd-server.keystore -O $DISTWEB/oxd-server/conf/oxd-server.keystore
    wget https://raw.githubusercontent.com/GluuFederation/oxd/$INSTALL/oxd-server/src/main/resources/oxd-server.yml -O $DISTWEB/oxd-server/conf/oxd-server.yml
    wget https://raw.githubusercontent.com/GluuFederation/oxd/$INSTALL/oxd-server/src/main/resources/swagger.yaml -O $DISTWEB/oxd-server/conf/swagger.yaml
    
    wget https://ox.gluu.org/maven/org/gluu/oxd-server/$OXD_SOURCE/oxd-server-$OXD_SOURCE.jar -O $DISTWEB/oxd-server/lib/oxd-server.jar
    cp /home/jenkins/oxd_files/bcprov-jdk15on-1.54.jar $DISTWEB/oxd-server/lib/    
    
    wget https://raw.githubusercontent.com/GluuFederation/oxd/$INSTALL/debian/oxd-server.service.file -O $DISTWEB/oxd-server/oxd-server.service
    pushd $DISTWEB/
      tar -cvzf oxd-server.tgz oxd-server
      rm -rf oxd-server
    popd
fi
