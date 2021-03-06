<!-- default file list -->
*Files to look at*:

* [Helper.cs](./CS/App_Code/Helper.cs) (VB: [Helper.vb](./VB/App_Code/Helper.vb))
* [Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/Default.aspx.vb))
* [script.js](./CS/script.js) (VB: [script.js](./VB/script.js))
<!-- default file list end -->
# How to use jQuery to drag and drop items from one ASPxGridView to another
<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/e1810/)**
<!-- run online end -->


<p>The example demonstrates how to use the jQuery framework to drag an item from one grid to another.</p>
<p>- Use jQuery UI <a href="http://jqueryui.com/draggable/">Draggable</a> and <a href="http://jqueryui.com/droppable/">Droppable</a> plug-ins;<br />- Define "draggable" and "droppable" items:</p>


```aspx
<Styles>
    <Table CssClass="droppableLeft"></Table>
    <Row CssClass="draggableRow left"></Row>
</Styles>

```


<p> - Use the invisible <strong>ASPxGlobalEvents</strong> control and handle its client-side ControlsInitialized/EndCallback events;<br />- Initialize the defined draggable/droppable items via the corresponding jQuery selectors. The "start" event handler can be used to obtain the key of the dragged row and apply conditional styling to it:</p>


```js
start: function (ev, ui) {
    var $sourceElement = $(ui.helper.context);
    var $draggingElement = $(ui.helper);
     //style elements
    $sourceElement.addClass("draggingStyle");
    $draggingElement.addClass("draggingStyle");
     //find key
    var sourceGrid = ASPxClientGridView.Cast($draggingElement.hasClass("left") ? "gridFrom" : "gridTo");
    rowKey = sourceGrid.GetRowKey($sourceElement.index() - 1);
}

```


<p>- Handle the "drop" event of the "droppable" items and perform a callback to the callback panel that has both grids nested inside to perform the data editing functionality.</p>
<p>Select the "script.js" source file and review the comments to find an illustration of the above steps.</p>
<br />
<p><strong>See </strong><strong>A</strong><strong>lso:<br /></strong><a href="https://www.devexpress.com/Support/Center/p/T116869">T116869: GridView - How to drag and drop items from one grid to another</a><strong><br /> </strong><a href="https://www.devexpress.com/Support/Center/p/E4582">E4582: How to reorder ASPxGridView rows using buttons or drag-and-drop</a></p>

<br/>


