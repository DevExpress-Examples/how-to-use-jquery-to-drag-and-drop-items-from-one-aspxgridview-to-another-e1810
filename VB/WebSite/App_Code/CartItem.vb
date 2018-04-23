Imports Microsoft.VisualBasic
Imports System

' Data object 

Public Class CartItem
	Private privateID As Int32
	Public Property ID() As Int32
		Get
			Return privateID
		End Get
		Set(ByVal value As Int32)
			privateID = value
		End Set
	End Property
	Private privateItemCode As Int32
	Public Property ItemCode() As Int32
		Get
			Return privateItemCode
		End Get
		Set(ByVal value As Int32)
			privateItemCode = value
		End Set
	End Property
	Private privateQuantity As Int32
	Public Property Quantity() As Int32
		Get
			Return privateQuantity
		End Get
		Set(ByVal value As Int32)
			privateQuantity = value
		End Set
	End Property
End Class