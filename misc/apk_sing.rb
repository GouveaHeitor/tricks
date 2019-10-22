#!/usr/bin/env ruby

def main
    apkfile  = ARGV[0]
    pkgname  = ARGV[1]
    password = ARGV[2]

    if apkfile && pkgname && password
        system("keytool -genkey -keystore \"#{pkgname}\" .jks -storepass \"#{password}\" -storetype jks -alias \"#{pkgname}\" -keyalg rsa -dname \"CN=DESEC\" -keypass \"#{password}\"")
        system("jarsigner -keystore \"#{pkgname}\" .jks -storepass \"#{password}\" -storetype jks -sigalg sha1withrsa -digestalg sha1 \"#{apkfile}\" \"#{pkgname}\"")
        system("jarsigner -verify -certs -verbose \"#{apkfile}\"")
        exit
    end

    return puts "ruby apk_sing.rb <apkfile.apk> <package_name> <password>\n"
end

main
exit