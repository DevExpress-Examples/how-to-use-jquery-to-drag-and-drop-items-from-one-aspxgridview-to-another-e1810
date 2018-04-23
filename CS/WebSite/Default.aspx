<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v10.2, Version=10.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v10.2, Version=10.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGlobalEvents" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="DX.ashx?jsfolder=~/Scripts" type="text/javascript"></script>
    <link href="DX.ashx?cssfolder=~/Content" type="text/css" rel="Stylesheet" />
    <title>How to use jQuery to drag and drop items from one ASPxGridView to another
    </title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 800px">
        <div class="dLeft">
            <dxwgv:ASPxGridView ID="gvMaster" ClientInstanceName="gridMaster" DataSourceID="sds"
                runat="server" KeyFieldName="CategoryID" AutoGenerateColumns="False" ClientIDMode="AutoID">
                <Columns>
                    <dxwgv:GridViewDataColumn FieldName="CategoryID" Caption="CategoryID" Width="75px">
                    </dxwgv:GridViewDataColumn>
                    <dxwgv:GridViewDataColumn FieldName="CategoryName" Caption="CategoryName" Width="230px">
                    </dxwgv:GridViewDataColumn>
                    <dxwgv:GridViewDataHyperLinkColumn FieldName="CategoryName" Caption="Image" ReadOnly="True">
                        <Settings AllowSort="False"></Settings>
                        <EditFormSettings Visible="False" />
                        <DataItemTemplate>
                            <div class="draggable">
                                <a href="#" title="Image Viewer">
                                    <img src="Images/drag.jpg" alt="" />
                                </a>
                                <input type="hidden" value='<%# Eval("CategoryID")%>' />
                            </div>
                        </DataItemTemplate>
                    </dxwgv:GridViewDataHyperLinkColumn>
                </Columns>
            </dxwgv:ASPxGridView>
        </div>
        <div class="dRight">
            <div class="droppable">
                <img id="imgBox" src="Images/box.jpg" alt="Drop an item here" />
                <dxwgv:ASPxGridView ID="gvCart" ClientInstanceName="grid" runat="server" KeyFieldName="ID"
                    AutoGenerateColumns="False" OnRowInserting="gvCart_RowInserting" OnBeforePerformDataSelect="gvCart_BeforePerformDataSelect"
                    OnCellEditorInitialize="gvCart_CellEditorInitialize" OnCancelRowEditing="gvCart_CancelRowEditing"
                    Width="300px">
                    <ClientSideEvents EndCallback="gvCart_EndCallback" />
                    <Columns>
                        <dxwgv:GridViewDataComboBoxColumn FieldName="ItemCode" VisibleIndex="0">
                            <PropertiesComboBox DataSourceID="sds" TextField="CategoryName" ValueField="CategoryID"
                                ValueType="System.Int32">
                            </PropertiesComboBox>
                        </dxwgv:GridViewDataComboBoxColumn>
                        <dxwgv:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="1">
                            <PropertiesTextEdit Width="100%">
                                <ValidationSettings Display="Dynamic">
                                    <RequiredField IsRequired="True" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                        </dxwgv:GridViewDataTextColumn>
                        <dxwgv:GridViewCommandColumn VisibleIndex="2">
                        </dxwgv:GridViewCommandColumn>
                    </Columns>
                    <SettingsEditing Mode="Inline" />
                </dxwgv:ASPxGridView>
            </div>
            <div class="cartArea">
                <b id="lbl">Your current choice</b>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="sds" runat="server" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
        SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="ge" runat="server">
        <ClientSideEvents ControlsInitialized="InitalizejQuery" EndCallback="InitalizejQuery" />
    </dx:ASPxGlobalEvents>
    </form>
</body>
</html>
