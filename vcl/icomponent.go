//----------------------------------------
//
// Copyright © ying32. All Rights Reserved.
//
// Licensed under Apache License 2.0
//
//----------------------------------------

package vcl

type IComponent interface {
	IObject
	Name() string
	SetName(string)
	FindComponent(string) *TComponent
	Tag() int
	SetTag(int)
	Components(int32) *TComponent
	Owner() *TComponent
	SetComponentIndex(int32)
	ComponentIndex() int32
	ComponentCount() int32
}
