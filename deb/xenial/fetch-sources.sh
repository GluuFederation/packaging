#!/bin/bash

VER=$1
INSTALL_VER=$2

DIRWEB="gluu-server.amd64/gluu-server-4.0/opt/dist/gluu"
COMMUNITY="gluu-server.amd64/gluu-server-4.0/install"

INSTALL="master"
if [ -n "${INSTALL_VER}" ]; then
    INSTALL=$INSTALL_VER
fi

if [ -n "${VER}" ]; then
    wget -nv http://ox.gluu.org/maven/org/xdi/oxshibbolethIdp/$VER/oxshibbolethIdp-$VER.war -O $DIRWEB/idp.war
    wget -nv http://ox.gluu.org/maven/org/xdi/oxtrust-server/$VER/oxtrust-server-$VER.war -O $DIRWEB/identity.war
    wget -nv http://ox.gluu.org/maven/org/xdi/oxauth-server/$VER/oxauth-server-$VER.war -O $DIRWEB/oxauth.war
    #wget -nv http://ox.gluu.org/maven/org/xdi/oxauth-rp/$VER/oxauth-rp-$VER.war -O $DIRWEB/oxauth-rp.war
    wget -nv http://ox.gluu.org/maven/org/xdi/oxShibbolethStatic/$VER/oxShibbolethStatic-$VER.jar -O $DIRWEB/shibboleth-idp.jar
    wget -nv http://ox.gluu.org/maven/org/xdi/oxShibbolethKeyGenerator/$VER/oxShibbolethKeyGenerator-$VER.jar -O $DIRWEB/idp3_cml_keygenerator.jar
    wget -nv https://ftp.osuosl.org/pub/gentoo/distfiles/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_7.tar.gz -O $DIRWEB/../app/OpenJDK11U-jdk_x64_linux_hotspot_11.0.2_7.tar.gz
    rm -rf $COMMUNITY/community-edition-setup*
    curl -LkSs https://codeload.github.com/GluuFederation/community-edition-setup/zip/$INSTALL -o $COMMUNITY/community-edition-setup.zip
    unzip $COMMUNITY/community-edition-setup.zip -d $COMMUNITY
    mv -nv $COMMUNITY/community-edition-setup-$INSTALL $COMMUNITY/community-edition-setup
    rm -rf $COMMUNITY/community-edition-setup.zip
    wget https://ox.gluu.org/npm/passport/passport-4.0.0.tgz -O $DIRWEB/passport.tgz
    wget https://ox.gluu.org/npm/passport/passport-master-node_modules.tar.gz -O $DIRWEB/passport-master-node_modules.tar.gz
    wget https://raw.githubusercontent.com/GluuFederation/community-edition-package/$INSTALL/package/initd/gluu-server -O gluu-server.amd64/debian/gluu-server-4.0.init.d
    chmod +x gluu-server.amd64/debian/gluu-server-4.0.init.d
fi
