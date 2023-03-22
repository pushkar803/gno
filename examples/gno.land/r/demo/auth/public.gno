package auth

import (
	"std"
	"gno.land/p/demo/acl"
)

var dir = acl.New()

func DefineRealmAccess(realmName, perm , address string){
	dir.AddUserPerm(std.Address(address), perm, realmName)
}

func CheckRealmAccess(realmName, perm, address string) bool {
	return dir.HasPerm(std.Address(address), perm, realmName)
}