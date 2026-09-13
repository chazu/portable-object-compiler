Summary: Bootstrap for Portable Object Compiler
Name: objc-bootstrap
Version: 3.4.17
Release: 1%{?dist}
Group: Development/Languages/Objective-C
License: LGPL-2.0-or-later
Source: https://sourceforge.net/projects/objc/files/src/objc-bootstrap-%{version}.tar.gz
BuildRequires: flex
BuildRequires: byacc
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

# redefine the default _prefix /usr to /opt/objc-boostrap
# the actual compiler is installed with the default /usr prefix
# but this is just the bootstrap compiler for compiling the real compiler
# when no previous objc rpm package exists
%define _prefix /opt/objc-bootstrap

%description
Package for bootstrapping the Portable Object Compiler when there is no previous package of the Portable Object Compiler available in a repository.

%prep
%setup -q
./configure OBJCDIR=%{_prefix} --prefix=$RPM_BUILD_ROOT%{_prefix}

%build

make

%install

rm -rf $RPM_BUILD_ROOT
mkdir $RPM_BUILD_ROOT
mkdir $RPM_BUILD_ROOT/opt
mkdir $RPM_BUILD_ROOT/opt/objc-bootstrap

make install

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%{_prefix}
%{_bindir}
%{_bindir}/objc
%{_bindir}/objc1
%{_bindir}/postlink
%{_libdir}
%{_libdir}/_prelink.o

%changelog
* Sat Jul 18 2026 David Stes <stes@telenet.be> 3.4.17
Use lib64 for linux aarch64

* Fri Jul 3 2026 David Stes <stes@telenet.be> 3.4.16
Update to 3.4.16

* Sat May 10 2025 David Stes <stes@telenet.be> 3.4.3
Update to 3.4.3

* Sat Feb 11 2023 David Stes <stes@telenet.be> 3.3.32
Use _prefix /opt/objc-bootstrap for bootstrap compiler

