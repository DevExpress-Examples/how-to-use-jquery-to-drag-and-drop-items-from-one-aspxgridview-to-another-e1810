using System;
using DevExpress.Web.ASPxGridView;
using System.Collections.Generic;

public partial class _Default : System.Web.UI.Page {
    Boolean removeItem = true;

    /* A list of items */

    List<CartItem> CartDataSource {
        get {
            const String key = "(some guid)";
            if (Session[key] == null) {

                List<CartItem> lst = new List<CartItem>();

                /* can put some initialization code */

                Session[key] = lst;
            }
            return (List<CartItem>)Session[key];
        }
    }

    protected void gvCart_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e) {
        ASPxGridView grid = sender as ASPxGridView;

        CartItem item = new CartItem {
            ID = CartDataSource.Count,
            ItemCode = Convert.ToInt32(e.NewValues["ItemCode"]),
            Quantity = Convert.ToInt32(e.NewValues["Quantity"])
        };

        CartItem oldItem = CartDataSource.Find(i => i.ItemCode == item.ItemCode);

        if (oldItem != null)
            oldItem.Quantity += item.Quantity;
        else
            CartDataSource.Add(item);

        /* we need to remove an item when the same item has been already added */
        removeItem = (oldItem != null);

        e.Cancel = true;
        grid.CancelEdit();
    }

    protected void Page_Load(Object sender, EventArgs e) {
        if (!IsPostBack)
            gvCart.DataBind();
    }

    protected void gvCart_BeforePerformDataSelect(object sender, EventArgs e) {
        ASPxGridView grid = sender as ASPxGridView;

        grid.DataSource = CartDataSource;
    }

    protected void gvCart_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e) {
        if (e.Column.FieldName == "ItemCode")
            e.Editor.ClientEnabled = false;
        else if (e.Column.FieldName == "Quantity")
            e.Editor.Focus();
    }

    protected void gvCart_CancelRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e) {
        ASPxGridView grid = sender as ASPxGridView;

        grid.JSProperties["cpRemoveItem"] = removeItem;
    }
}
