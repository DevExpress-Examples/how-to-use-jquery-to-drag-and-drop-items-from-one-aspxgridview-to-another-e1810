Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web.ASPxGridView
Imports System.Collections.Generic

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Private removeItem As Boolean = True

	' A list of items 

	Private ReadOnly Property CartDataSource() As List(Of CartItem)
		Get
			Const key As String = "(some guid)"
			If Session(key) Is Nothing Then

				Dim lst As New List(Of CartItem)()

				' can put some initialization code 

				Session(key) = lst
			End If
			Return CType(Session(key), List(Of CartItem))
		End Get
	End Property

	Protected Sub gvCart_RowInserting(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)
		Dim grid As ASPxGridView = TryCast(sender, ASPxGridView)

		Dim item As CartItem = New CartItem With {.ID = CartDataSource.Count, .ItemCode = Convert.ToInt32(e.NewValues("ItemCode")), .Quantity = Convert.ToInt32(e.NewValues("Quantity"))}

		Dim oldItem As CartItem = CartDataSource.Find(Function(i) i.ItemCode = item.ItemCode)

		If oldItem IsNot Nothing Then
			oldItem.Quantity += item.Quantity
		Else
			CartDataSource.Add(item)
		End If

		' we need to remove an item when the same item has been already added 
		removeItem = (oldItem IsNot Nothing)

		e.Cancel = True
		grid.CancelEdit()
	End Sub

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If (Not IsPostBack) Then
			gvCart.DataBind()
		End If
	End Sub

	Protected Sub gvCart_BeforePerformDataSelect(ByVal sender As Object, ByVal e As EventArgs)
		Dim grid As ASPxGridView = TryCast(sender, ASPxGridView)

		grid.DataSource = CartDataSource
	End Sub

	Protected Sub gvCart_CellEditorInitialize(ByVal sender As Object, ByVal e As ASPxGridViewEditorEventArgs)
		If e.Column.FieldName = "ItemCode" Then
			e.Editor.ClientEnabled = False
		ElseIf e.Column.FieldName = "Quantity" Then
			e.Editor.Focus()
		End If
	End Sub

	Protected Sub gvCart_CancelRowEditing(ByVal sender As Object, ByVal e As DevExpress.Web.Data.ASPxStartRowEditingEventArgs)
		Dim grid As ASPxGridView = TryCast(sender, ASPxGridView)

		grid.JSProperties("cpRemoveItem") = removeItem
	End Sub
End Class
