<%@ Page Title="Review Rates" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ReviewRateList.aspx.cs" Inherits="Fnb_Order.Admin.ReviewRateList" %>
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

          //  BindModule();

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
                    dateFormat: 'yy-mm-dd',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2020:2022'
                }); 
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <asp:ScriptManager ID="srptMgr" runat="server"></asp:ScriptManager>
       <div id="dvITTransaction" class="main-content">
        <div class="row dv-header">
            <div class="main-header-text">Review Rate List</div>
        </div>

        <div class="main-body-content">
            <div style="margin: 100px" class="text-center">
<div style="margin: auto; max-width: 400px; height:auto; overflow:auto; margin-bottom: 15px;" class="select-type">           
                <div style="width:100px;float:left;line-height:33px;">Select Date:</div> <asp:TextBox ID="txtDate" runat="server" style="width:100px;float:left;" CssClass="datepicker input-with-feedback form-control" ></asp:TextBox>
                <asp:Button ID="btnGetRate" runat="server" CssClass="btn btn-primary" Text="Get" style="width:100px;float:left;margin-left:20px;" OnClick="btnGetRate_Click" /></div>
                            <center>
                                <asp:UpdatePanel ID="udpReviewRateList" runat="server" >
                                    <ContentTemplate>
                                <asp:GridView ID="gvReviewRateList" runat="server" OnRowDataBound="gvReviewRateList_RowDataBound" OnRowEditing="gvReviewRateList_RowEditing" OnRowUpdating="gvReviewRateList_RowUpdating" OnRowCancelingEdit="gvReviewRateList_RowCancelingEdit" AutoGenerateColumns="false" AllowPaging ="true" OnPageIndexChanging="gvReviewRateList_PageIndexChanging" PageSize="12" CellPadding="4" ForeColor="#333333" GridLines="None">
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <PagerSettings Position="TopAndBottom" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                <Columns>
                                    <asp:TemplateField HeaderText="#.">
                                    <ItemTemplate>
                                    <asp:Label ID="lblserial" runat="server" Text='<%# Container.DataItemIndex + 1 %>' ></asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                    <asp:HiddenField ID="hdnID" runat="server" Value ='<%# Eval("ID") %>' />
                                        <asp:Label ID="lblItem" runat="server" Text='<%# Eval("Item") %>' tooltip='<%# "Product ID :- " + Eval("ProductID") + "\nMargin (1-4)/Kg :- " + Eval("MR1") + "\nMargin (5-24)/Kg :- " + Eval("MR5") + "\nMargin (25-49)/Kg :- " + Eval("MR25") + "\nMargin (50 or More)/Kg :- " + Eval("MR50") %>' ></asp:Label>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                   <asp:TemplateField HeaderText="PR-1" ControlStyle-BackColor="Yellow">
                                    <ItemTemplate>
                                    <asp:Label ID="lblpr1" runat="server" Text='<%# Eval("PR1") %>'  tooltip='Purchase Rate' ></asp:Label>
                                    </ItemTemplate>
                                       <ControlStyle BackColor="Yellow" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR-1" >
                                    <ItemTemplate>
                                    <asp:Label ID="lblsr1" runat="server" Text='<%# Eval("SR1") %>' Width="20" tooltip='Sale Rate Including Margin.' ></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                    <asp:TextBox ID="txtsr1" runat="server" Text='<%# Eval("SR1") %>' Width="20" tooltip='Sale Rate Including Margin.' ></asp:TextBox>
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PR-5" ControlStyle-BackColor="Yellow">
                                    <ItemTemplate>
                                    <asp:Label ID="lblpr5" runat="server" Text='<%# Eval("PR5") %>' tooltip='Purchase Rate' ></asp:Label>
                                    </ItemTemplate>
                                        <ControlStyle BackColor="Yellow" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR-5">
                                    <ItemTemplate>
                                    <asp:Label ID="lblsr5" runat="server" Text='<%# Eval("SR5") %>' Width="20" tooltip='Sale Rate Including Margin.' ></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                    <asp:TextBox ID="txtsr5" runat="server" Text='<%# Eval("SR5") %>' Width="20" tooltip='Sale Rate Including Margin.' ></asp:TextBox>
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PR-25" ControlStyle-BackColor="Yellow" >
                                    <ItemTemplate>
                                    <asp:Label ID="lblpr25" runat="server" Text='<%# Eval("PR25") %>' tooltip='Purchase Rate' ></asp:Label>
                                    </ItemTemplate>
                                        <ControlStyle BackColor="Yellow" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR-25">
                                    <ItemTemplate>
                                    <asp:Label ID="lblsr25" runat="server" Text='<%# Eval("SR25") %>' Width="20" tooltip='Sale Rate Including Margin.' ></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                    <asp:TextBox ID="txtsr25" runat="server" Text='<%# Eval("SR25") %>' Width="20" tooltip='Sale Rate Including Margin.' ></asp:TextBox>
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PR-50" ControlStyle-BackColor="Yellow">
                                    <ItemTemplate>
                                    <asp:Label ID="lblpr50" runat="server" Text='<%# Eval("PR50") %>' tooltip='Purchase Rate' ></asp:Label>
                                    </ItemTemplate>
                                        <ControlStyle BackColor="Yellow" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR-50">
                                    <ItemTemplate>
                                    <asp:Label ID="lblsr50" runat="server" Text='<%# Eval("SR50") %>' Width="20" tooltip='Sale Rate Including Margin.' ></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                    <asp:TextBox ID="txtsr50" runat="server" Text='<%# Eval("SR50") %>' Width="20" tooltip='Sale Rate Including Margin.' ></asp:TextBox>
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>  
                                    <ItemTemplate>  
                                        <asp:Button ID="btn_Edit" CssClass="btn btn-primary" runat="server" Text="Edit" CommandName="Edit" />  
                                    </ItemTemplate>  
                                    <EditItemTemplate>  
                                        <asp:Button ID="btn_Update" CssClass="btn btn-primary" runat="server" Text="Update" CommandName="Update"/>  
                                        <asp:Button ID="btn_Cancel" CssClass="btn btn-primary" runat="server" Text="Cancel" CommandName="Cancel"/>  
                                    </EditItemTemplate>  
                                </asp:TemplateField>  
                                </Columns>
                            </asp:GridView>  
                                        </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger  ControlID="gvReviewRateList" />
                                    </Triggers>
                                    </asp:UpdatePanel>
                                </center>
            <%--        <p>
                <asp:Button ID="btnuploadRatelist" runat="server" CssClass="btn btn-primary" Text="Upload"  />
                </p>
                <asp:Label ID="lblmessage" runat="server" ></asp:Label>--%>
            </div>
        </div>
    </div>

</asp:Content>
