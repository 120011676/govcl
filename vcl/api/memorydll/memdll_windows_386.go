// +build windows,386


//----------------------------------------
// 
// Copyright © ying32. All Rights Reserved.
// 
// Licensed under Apache License 2.0
//
//----------------------------------------


package memorydll

import (
	"unsafe"

	"github.com/ying32/govcl/vcl/api/memorydll/btmemorymodule"
)

type moduleHandle = *btmemorymodule.TBTMemoryModule

func memoryLoadLibary(data []byte) moduleHandle {
	return btmemorymodule.BTMemoryLoadLibary(uintptr(unsafe.Pointer(&data[0])), int64(len(data)))
}

func memoryGetLastError() string {
	return btmemorymodule.BTMemoryGetLastError()
}

func memoryFreeLibrary(handle moduleHandle) {
	btmemorymodule.BTMemoryFreeLibrary(handle)
}

func memoryGetProcAddress(handle moduleHandle, name string) uintptr {
	return btmemorymodule.BTMemoryGetProcAddress(handle, name)
}

func handleIsValid(handle moduleHandle) bool {
	return handle.IsValid()
}
