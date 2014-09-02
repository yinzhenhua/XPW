<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ElectricityConsumptionPage.aspx.cs" Inherits="XPW.ElectricityConsumptionPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <table>
            <tr>
                <td style="width: 10px">
                    <asp:Label ID="lblSite" runat="server" Text="Site"></asp:Label>
                </td>
                <td style="width: auto">
                    <asp:DropDownList runat="server" ID="dlSite" AutoPostBack=" true" OnSelectedIndexChanged="dlSite_SelectedIndexChanged"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView runat="server" ID="gvDept" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="DeviceID" HeaderText="" ShowHeader="false" Visible="false" />
                            <asp:BoundField DataField="Name" HeaderText="Dept." />
                            <asp:BoundField DataField="PreviousYear" HeaderText="Previous Year" />
                            <asp:BoundField DataField="YearlyTarget" HeaderText="Yearly Target" />
                            <asp:BoundField DataField="YTD" HeaderText="YTD" />
                            <asp:BoundField DataField="Percentage" HeaderText="%" />
                            <asp:BoundField DataField="Q1" HeaderText="Q1" />
                            <asp:BoundField DataField="Q2" HeaderText="Q2" />
                            <asp:BoundField DataField="Q3" HeaderText="Q3" />
                            <asp:BoundField DataField="Q4" HeaderText="Q4" />
                            <asp:BoundField DataField="Month1" HeaderText="" />
                            <asp:BoundField DataField="Month2" HeaderText="" />
                            <asp:BoundField DataField="Month3" HeaderText="" />
                            <asp:BoundField DataField="Week1" HeaderText="Week-1" />
                            <asp:BoundField DataField="Week2" HeaderText="Week-2" />
                            <asp:BoundField DataField="Week3" HeaderText="Week-3" />
                            <asp:BoundField DataField="Week4" HeaderText="Week-4" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Image runat="Server" ID="btnGraph" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Chart ID="ecpChart" runat="server" Visible="false" Width="800">
                        <Series>
                            <asp:Series Name="ecpSeries">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ecpChartArea"></asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
