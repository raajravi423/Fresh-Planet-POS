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
    width: 100%;
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
    <script type="text/javascript" >
        $(document).ready(function () {
           // BindModule();
            $("#btnstart").on("click", function () {
                var selval = $("#ddlfnbactivitylist").val();
                if (selval != '0') {
                    window.location = selval;
                }
                else {
                    alert("Please Select Atleast One Activity.");
                }
            });

            $('.datepicker').datepicker(
                {
                    minDate:0,
                    dateFormat: 'yy-mm-dd',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2020:2022'
                }); 
        });
        
    </script> 
    <style type="text/css">
        .tbl-default{
            width: 100%;
        }
        .td-default {
          float:right
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
       <div id="dvITTransaction" class="main-content">
        <div class="row dv-header">
            <div class="main-header-text">Create Order</div>
        </div>
        <div class="main-body-content">

            <table class="tbl-default">
                <tr>
                    <td style="width:50%;">
                        <table class="tbl-default">
                            <tr>
                                <td>
                                    <asp:RadioButtonList ID="rdoCustomerType" TextAlign="left" runat="server">
                                        <asp:ListItem Text="FP-GF" Value="FP-GF" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <th>Order Date:</th>
                                <td><asp:TextBox ID="txtDate" runat="server" CssClass="datepicker input-with-feedback form-control" ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <th>Customer ID:</th>
                                <td colspan="2"><asp:TextBox ID="txtCustomerID" runat="server" CssClass="input-with-feedback form-control" ></asp:TextBox></td>
                                <td><asp:Button ID="btnSearchCustomer" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btnSearchCustomer_Click1" /></td>
                                </tr>
                            <tr>
                                <th>Select Item:</th>
                                <td colspan="3"><asp:TextBox ID="txtSelectItem" runat="server" CssClass="input-with-feedback form-control" ></asp:TextBox></td>
                            </tr>
                        </table>


                    </td>
                    <td style="width:50%;">
                         <table class="tbl-default">
                            <tr>
                                <th>Customer ID:</th>
                                <td><asp:Label ID="lblCustomerID" Text="GF-FP-03" runat="server"></asp:Label></td>
                                <th>Order Date:</th>
                                <td><asp:Label ID="lblOrderDate" runat="server" Text="24-04-2021"></asp:Label></td>
                                </tr>
                             <tr>
                                 <th>Customer Name:</th>
                                 <td><asp:Label ID="lblCustomerName" Text="Bala Ji Store" runat="server"></asp:Label></td>
                                 <th>Contact No:</th>
                                 <td><asp:Label ID="lblContactNo" runat="server" Text="987654321"></asp:Label></td>
                                 </tr>
                                 <tr>
                                 <th>Address:</th>
                                 <td colspan="3"><asp:Label ID="lblAddress" Text="SG-116, RPS Galleria, RPS Sector-88 Faridabad." runat="server"></asp:Label></td>
                                 </tr>
                                 <tr>
                                 <td colspan="4">
                                 <asp:GridView ID="gvOrderItem" runat="server" ></asp:GridView>
                                 </td>
                             </tr>
                             </table>


                    </td>
                </tr>
            </table>

    </div>
       </div>
</asp:Content>