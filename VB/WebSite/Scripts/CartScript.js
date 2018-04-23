var itemCode = 0;

function InitalizejQuery() {
    $('.draggable').draggable({ helper: 'clone' });
    $('.droppable').droppable(
                {
                    activeClass: "hover",
                    drop: function (ev, ui) {
                        // 
                        $("#imgBox").attr("src", "Images/boxfilled.gif");

                        // make a clone of the dragged item
                        var clone = (ui.draggable).clone();

                        // remove "Your current choice" label
                        $("#lbl").remove();

                        // add the clone into the cartArea container
                        if (!grid.IsEditing())
                            $(clone).appendTo(".cartArea").css("display", "inline-block");

                        // get the Item Code:
                        itemCode = $(clone).find("input[type='hidden']").val();

                        // add a new item
                        grid.AddNewRow();
                    }
                }
              );
}

function gvCart_EndCallback(s, e) {
    if (grid.IsEditing())
        grid.SetEditValue('ItemCode', itemCode);
    else {
        $("#imgBox").attr("src", "Images/box.jpg");

        if (s.cpRemoveItem) { // remove unnecessary item
            s.cpRemoveItem = false;

            $(".cartArea .draggable:last-child").remove();
        }
    }
}