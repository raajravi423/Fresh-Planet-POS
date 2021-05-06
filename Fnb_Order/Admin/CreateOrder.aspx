<%@ Page Title="Create Order" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="CreateOrder.aspx.cs" Inherits="Fnb_Order.Admin.CreateOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css" >
        .main-content {
    border: 1px solid #c7c7c7;
    border-radius: 4px;
    box-shadow: 2px 2px 7px #ccc;
    height: auto;
    margin-top: 15px;
    min-height: 450px;
    overflow: auto;
    padding-bottom: 20px;
    width: 100%;
}
.dv-header {
    background-color: #f9f9f9;
    font-size: 22px;
    line-height: 50px;
}

.row {
    border-bottom: 1px solid #c7c7c7;
}


.main-header-text {
    text-align: center;
    width: 100%;
}

.text-center {
    text-align: center;
}


.form-control {
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    color: #555;
    display: block;
    font-size: 14px;
    line-height: 1.42857;
    padding: 6px 12px;
    width: 200px;
}


.btn {
    -moz-user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    cursor: pointer;
    display: inline-block;
    font-size: 14px;
    font-weight: normal;
    line-height: 1.42857;
    margin-bottom: 0;
    padding: 6px 12px;
    text-align: center;
    vertical-align: middle;
    white-space: nowrap;
}
.btn-primary {
    background-color: #2980b9;
    border-color: #2472a4;
    color: #fff;
}

 .btn-primary:hover {
    background-color: #20638f;
    
    }


    </style>
    
    <script type="text/javascript">

        $(document).ready(function () {
            
           // BindModule();
            //$("#btnstart").on("click", function () {
            //    var selval = $("#ddlfnbactivitylist").val();
            //    if (selval != '0') {
            //        window.location = selval;
            //    }
            //    else {
            //        alert("Please Select Atleast One Activity.");
            //    }
            //});

            $('.datepicker').datepicker(
                {
                    minDate:0,
                    dateFormat: 'yy-mm-dd',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2020:2022'
                }); 


            $("#<%=txtSelectItem.ClientID%>").autocomplete({
                
                source: function (request, response) {
                    
                    var param = { Itemname: $('#<%=txtSelectItem.ClientID%>').val() };
                     
                    $.ajax({
                        url: "CreateOrder.aspx/getItems",
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {
                            console.log(JSON.stringify(data));
                            response($.map(data.d, function (item) {
                                // console.log({  Name: item.EmpName });

                              <%--  this.alert(item.ItemsDbKey);
                                $('#<%=lblItemID.ClientID%>').val(item.split('-')[1])  --%>
                                return {
                                    label: item.split('-')[1],
                                    value: item.split('-')[1],
                                    data: item.split('-')[0]
                                    //value: item.ItemsName
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                            // console.log("Ajax Error!");  
                        }
                    });
                },
                select: function (event, ui) {
                    
            <%--        $('#<%=lblVegItems.ClientID%>').text(ui.item.value)--%>;
                    $('#<%=hdnItemID.ClientID%>').attr('value',ui.item.data); 
                 
                },
                minLength: 2 //This is the Char length of inputTextBox  
            });  //
        });
        
    </script> 
    <style type="text/css">
        .tbl-default{
            width: 100%;
        }
        .td-default {
          float:right
        }
        #main-form > td {
        width:auto%;
        }
        #main-form > th {
        text-align:right;
        width:auto;
        overflow:auto;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
       <div id="dvITTransaction" class="main-content">
        <div class="row dv-header">
            <div class="main-header-text">Create Order</div>
        </div>
        <div class="main-body-content">

            <table id="main-form" class="tbl-default">
                <tr>
                    <td style="width:30%;">
                        <table class="tbl-default">
                            <tr>
                                <th></th>
                                <th  style="text-align:center;">
                                    <asp:RadioButtonList ID="rdoCustomerType" TextAlign="right" runat="server">
                                        <asp:ListItem Text="FPBGF" Value="FPBGF" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </th>
                                </tr>
                            <tr>
                                <th>Order Date:</th>
                                <td><asp:TextBox ID="txtDate" runat="server" CssClass="datepicker input-with-feedback form-control" ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>Customer ID:</th>
                                <td><asp:TextBox ID="txtCustomerID" runat="server" placeholder="Customer ID Ex. 1,2.." CssClass="input-with-feedback form-control" ></asp:TextBox></td>
                                <td><asp:Button ID="btnSearchCustomer" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btnSearchCustomer_Click1" /></td>
                                </tr>
                            <tr>
                                <th>Select Item:</th>
                                <td ><asp:TextBox ID="txtSelectItem" runat="server" placeholder="Item Name" CssClass="input-with-feedback form-control"  ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>Qty.</th>
                                <td >
                                    <asp:TextBox ID="txtQuantity" runat="server" placeholder="Weight in Kg." CssClass="input-with-feedback form-control" ></asp:TextBox>
                                 </td>
                                <td>
<%--                                    <asp:Label ID="Label2" runat="server" Visible="true" Text="KG"></asp:Label>--%>
                                    <asp:Button ID="BtnAddQuantity" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="BtnAddQuantity_Click" />

<%--                                    <asp:Label ID="lblVegItems" runat="server" Visible="true" Text=""></asp:Label>
                                    <asp:Label ID="Label1" runat="server" Visible="true" Text="X"></asp:Label>--%>

                                    
                                   

                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                  <asp:HiddenField ID="hdnItemID" runat="server" />
                                </td>
                            </tr>
                        </table>


                    </td>
                    <td style="width:50%;">
                        <asp:UpdatePanel ID="udpcutomerdetails" runat="server">     
                            <ContentTemplate>
                            <asp:Panel ID="pnlcustomerdetail" runat="server" Visible="false">
                                <table class="tbl-default">
                            <tr>
                                <th>Customer ID:</th>
                                <td><asp:Label ID="lblCustomerID"  runat="server"></asp:Label></td>
                                <th>Order Date:</th>
                                <td><asp:Label ID="lblOrderDate" runat="server" ></asp:Label></td>
                                </tr>
                             <tr>
                                 <th>Customer Name:</th>
                                 <td><asp:Label ID="lblCustomerName"  runat="server"></asp:Label></td>
                                 <th>Contact No:</th>
                                 <td><asp:Label ID="lblContactNo" runat="server" Text="987654321"></asp:Label></td>
                                 </tr>
                                 <tr>
                                 <th>Address:</th>
                                 <td colspan="3"><asp:Label ID="lblAddress" runat="server"></asp:Label></td>
                                 </tr>

                             <tr>
                                 <td colspan="4">
                                     <asp:Button ID="BtnCreateOrder" runat="server" CssClass="btn btn-primary" Text="Create Order" OnClick="BtnCreateOrder_Click" />
                                 </td>
                             </tr>

                                 <tr>
                                 <td colspan="4">
                                 <asp:GridView ID="gvOrderItem" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None"  
                                      DataKeyNames ="ItemID" OnRowEditing ="Edit" AutoGenerateColumns="false"                
                                     OnRowCancelingEdit="canceledit" OnRowDeleting="delete" OnRowUpdating="Update">
                                     <AlternatingRowStyle BackColor="White" />
                                     <Columns>
                                        <asp:CommandField ShowEditButton="True" />
                                        <asp:CommandField ShowDeleteButton="True" />
                                          <asp:boundfield datafield="SERIAL" readonly="true" headertext="SERIAL"/>
                                      <asp:boundfield datafield="ItemID" readonly="true" headertext="ItemID"/>
                                      <asp:boundfield datafield="ItemName" readonly="true"  headertext="ItemName"/>
                                      <asp:boundfield datafield="Qty" headertext="Qty"/>
                                      <asp:boundfield datafield="RateSlab" readonly="true"  headertext="RateSlab"/>
                                         <asp:boundfield datafield="Rate" readonly="true"  headertext="Rate"/>
                                         <asp:boundfield datafield="TotalAmount" readonly="true"  headertext="TotalAmount"/>
                                    </Columns>

                                     <EditRowStyle BackColor="#2461BF" />
                                     <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                     <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                     <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                     <RowStyle BackColor="#EFF3FB" />
                                     <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                     <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                     <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                     <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                     <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                     </asp:GridView>
                                 </td>
                             </tr>

                             <tr>
                                 <td colspan="4">
                                  </td>

                             </tr>
                             </table>
                                </asp:Panel>
                            </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearchCustomer" />

                        </Triggers>    
                        </asp:UpdatePanel> 


                    </td>
                </tr>
            </table>

    </div>
       </div>
       </div>
</asp:Content>