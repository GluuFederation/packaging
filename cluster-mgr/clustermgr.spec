Name:		clustermgr
Version:	%VERSION%
Release:	%RELEASE%
Summary:	OAuth protected API
License:	GUI tool for installing and managing clustered Gluu Servers 
URL:  https://www.gluu.org
Source0:	clustermgr-4.1.0.tgz
Source1:	clustermgr.service
BuildArch:  noarch

%description
Cluster Manager (CM) is a GUI tool for installing and managing a highly available, 
clustered Gluu Server infrastructure on physical servers or VMs

%prep
%setup -q

%install
mkdir -p %{buildroot}/tmp/
mkdir -p %{buildroot}/opt/
mkdir -p %{buildroot}/lib/systemd/system/
cp -a %{SOURCE1} %{buildroot}/lib/systemd/system/clustermgr.service
cp -a opt/clustermgr %{buildroot}/opt/


%pre
mkdir -p /opt

%post
systemctl enable clustermgr > /dev/null 2>&1
systemctl start clustermgr > /dev/null 2>&1

%preun
systemctl stop clustermgr > /dev/null 2>&1

%postun
if [ "$1" = 0 ]; then 
rm -rf /opt/clustermgr  > /dev/null 2>&1
fi


%changelog
* Wed Apr 29 2020 Davit Nikoghosyan <davit@gluu.org> - %VERSION%-1
- Release %VERSION%
