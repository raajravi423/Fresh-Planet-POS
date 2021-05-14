<%@ Page Title="Create Order" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="CreateOrder.aspx.cs" Inherits="Fnb_Order.Admin.CreateOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
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
            text-decoration:none;
        }

            .btn-primary:hover {
                background-color: #20638f;
            }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.datepicker').datepicker(
                {
                    minDate: 0,
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
                                return {
                                    label: item.split('-')[1],
                                    value: item.split('-')[1],
                                    data: item.split('-')[0]
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                        }
                    });
                },
                select: function (event, ui) {
                    $('#<%=hdnItemID.ClientID%>').attr('value', ui.item.data);
                },
                minLength: 2 //This is the Char length of inputTextBox  
            });  //
        });

    </script>
    <style type="text/css">
        .td-default {
            float: right
        }

        #main-form > td {
            width: 200px;
        }

        #main-form > th {
            text-align: right;
            width: auto;
            overflow: auto;
        }

        #customerdetail {
            width: 100%;
        }

            #customerdetail > th {
                text-align: right;
                width: auto;
                overflow: auto;
            }

           
        .grid-header {
        text-align:left;
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
                    <td style="width: 30%;">
                        <table class="tbl-default">
                            <tr>
                                <th></th>
                                <th style="text-align: center;">
                                    <asp:RadioButtonList ID="rdoCustomerType" TextAlign="right" runat="server" TabIndex="0">

                                        <asp:ListItem Text="FPBGF" Value="FPBGF" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </th>
                            </tr>
                            <tr>
                                <th>Order Date:</th>
                                <td>
                                    <asp:TextBox ID="txtDate" runat="server" CssClass="datepicker input-with-feedback form-control" TabIndex="1"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>Customer ID:</th>
                                <td>
                                    <asp:TextBox ID="txtCustomerID" runat="server" placeholder="Customer ID Ex. 1,2.." CssClass="input-with-feedback form-control" TabIndex="2"></asp:TextBox></td>
                                <td>
                                    <asp:Button ID="btnSearchCustomer" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btnSearchCustomer_Click1" TabIndex="3" /></td>
                            </tr>
                            <tr>
                                <th>Select Item:</th>
                                <td>
                                    <asp:TextBox ID="txtSelectItem" runat="server" placeholder="Item Name" CssClass="input-with-feedback form-control" TabIndex="4"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>Qty.</th>
                                <td>
                                    <asp:TextBox ID="txtQuantity" runat="server" placeholder="Weight in Kg." CssClass="input-with-feedback form-control" TabIndex="5"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="BtnAddQuantity" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="BtnAddQuantity_Click" TabIndex="6" />


                                    
                                   

                                </td>
                            </tr>
                            </table>
                            </td>
                    <td style="width: 50%;">
                        <asp:UpdatePanel ID="udpcutomerdetails" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnlcustomerdetail" runat="server" Visible="false">
                                    <table id="customerdetail">
                                        <tr>
                                            <th>Customer ID:</th>
                                            <td>
                                                <asp:Label ID="lblCustomerID" runat="server"></asp:Label></td>
                                            <th>Order Date:</th>
                                            <td>
                                                <asp:Label ID="lblOrderDate" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Customer Name:</th>
                                            <td>
                                                <asp:Label ID="lblCustomerName" runat="server"></asp:Label></td>
                                            <th>Contact No:</th>
                                            <td>
                                                <asp:Label ID="lblContactNo" runat="server" Text="987654321"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <th>Address:</th>
                                            <td colspan="3">
                                                <asp:Label ID="lblAddress" runat="server"></asp:Label></td>
                                        </tr>

                                        <tr>
                                            <td colspan="4">
                                                <asp:Button ID="BtnCreateOrder" runat="server" CssClass="btn btn-primary" Text="Create Order" OnClick="BtnCreateOrder_Click" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="4">
                                                <asp:GridView ID="gvOrderItem" Width="500px" runat="server" CellPadding="4" ForeColor="Black" GridLines="Horizontal" 
                                                    DataKeyNames="ItemID" OnRowEditing="Edit" AutoGenerateColumns="False" 
                                                    OnRowCancelingEdit="canceledit" OnRowDeleting="delete" OnRowUpdating="Update" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                                                    <Columns>
                                                        <asp:BoundField DataField="SERIAL" ReadOnly="true" ControlStyle-Width="15px" HeaderText="#" HeaderStyle-CssClass="grid-header" >
                                                        <ControlStyle Width="15px" />
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ItemID" ReadOnly="true" ControlStyle-Width="15px" HeaderText="ID" HeaderStyle-CssClass="grid-header" >
                                                        <ControlStyle Width="15px" />
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ItemName" ReadOnly="true" ControlStyle-Width="150px" HeaderText="ItemName" HeaderStyle-CssClass="grid-header" >
                                                        <ControlStyle Width="150px" />
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Qty" HeaderText="Qty" ControlStyle-Width="30px" HeaderStyle-CssClass="grid-header" >
                                                        <ControlStyle Width="30px" />
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="RateSlab" ReadOnly="true" Visible="false" HeaderText="RateSlab" HeaderStyle-CssClass="grid-header" >
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Rate" ReadOnly="true" Visible="false" HeaderText="Rate" HeaderStyle-CssClass="grid-header" >
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="TotalAmount" ReadOnly="true" Visible="false" HeaderText="TotalAmount" HeaderStyle-CssClass="grid-header" >
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:BoundField>
                                                        <asp:CommandField ShowEditButton="True" ControlStyle-CssClass="btn btn-primary"  HeaderStyle-CssClass="grid-header" >
                                                        <ControlStyle CssClass="btn btn-primary" />
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:CommandField>
                                                        <asp:CommandField ShowDeleteButton="True" ControlStyle-CssClass="btn btn-primary" HeaderStyle-CssClass="grid-header" >
                                                        <ControlStyle CssClass="btn btn-primary" />
                                                        <HeaderStyle CssClass="grid-header" />
                                                        </asp:CommandField>
                                                        <asp:TemplateField>
                                                            <FooterTemplate>
                                                        <asp:Label ID ="lbltotalqty" runat="server" ></asp:Label>                                                                
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>                                                   
                                                    
                                                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                                    <HeaderStyle BackColor="#01a3a3" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                                    <SortedDescendingHeaderStyle BackColor="#242121" />
                                                </asp:GridView>
                                                
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="4"></td>

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
                <tr>
                    <td>
                        <asp:HiddenField ID="hdnItemID" runat="server" />
                    </td>
                </tr>
            </table>
           
        </div>
    </div>
</asp:Content>
