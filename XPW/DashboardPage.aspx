<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DashboardPage.aspx.cs" Inherits="XPW.DashboardPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="Scripts/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#min').click(function () {
                $('#div_chart').hide(500);
                $('#div_chart').css('display', 'none');
                $('#max').show(200);
                $(this).hide(200);
            });
            $('#max').click(function () {
                $('#div_chart').show(500);
                $(this).hide(200);
                $('#min').show(200);
            });

            $('#min_enery').click(function () {
                $('#energy').hide(500);
                $('#max_enery').show(200);
                $(this).hide(200);
            });
            $('#max_enery').click(function () {
                $('#energy').show(500);
                $(this).hide(200);
                $('#min_enery').show(200);
            });
            $('tr').mouseover(function() {
                $(this).css("background-color", "#def0d1");
            });
            $('tr').mouseout(function() {
                $(this).css("background-color", "#f0fbe8");
            });
        });
    </script>
    <style type="text/css">
        #div_chart {
            width: 674px;
            height: 248px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="floatDiv leftWidth subContainer">
            <img src="Images/sd.png" alt="Sandisk"/>
        </div>
        <div class="floatDiv subContainer" style="padding: 0;">
            <div class="titleBar">
                <asp:LinkButton ID="lnk_Water" runat="server" CommandArgument="373" OnClick="OnLinkClick"><img src="Images/water.png" alt="水" /></asp:LinkButton>
                <asp:LinkButton ID="lnk_elctr" runat="server" CommandArgument="388" OnClick="OnLinkClick"><img src="Images/electricity.png" alt="电" /></asp:LinkButton>
                <asp:LinkButton ID="lnk_Lng" runat="server" CommandArgument="358" OnClick="OnLinkClick"><img src="Images/natural.png" alt="煤" /></asp:LinkButton>
                <a href='#' id="min">
                    <img src="Images/min.png" height="22"  alt="最小化" /></a>
                <a href='#' id="max" style="display: none">
                    <img src="Images/max.png" height="22"  alt="最大化"/></a>
            </div>
            <div id="div_chart">
                <asp:Chart ID="chartEnerge" runat="server" Width="710px" Height="245px"
                    Palette="BrightPastel" ImageType="Png" BorderlineDashStyle="Solid"
                    BackColor="#F3DFC1" BorderDashStyle="Solid" BackGradientStyle="TopBottom" BorderWidth="1" BorderColor="181, 64, 1" OnClick="OnChartClick">
                    <%--<Legends>
                    <asp:Legend Name="Default" Docking="Bottom">
                    </asp:Legend>
                </Legends>--%>
                    <%--<BorderSkin SkinStyle="Emboss" />--%>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid"
                            BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent"
                            BackGradientStyle="TopBottom">
                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False" WallWidth="0" IsClustered="False"></Area3DStyle>
                            <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
                                <LabelStyle Font="微软雅黑, 6.5pt, style=Bold" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisY>
                            <AxisX LineColor="Transparent" IsLabelAutoFit="False" LineWidth="0" TitleFont="宋体, 6pt">
                                <LabelStyle Font="微软雅黑, 6.5pt, style=Bold" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisX>
                        </asp:ChartArea>
                    </ChartAreas>

                </asp:Chart>
            </div>
        </div>
    </div>
    <div style="clear: both;">
        <div class="floatDiv leftWidth co2 subContainer">
            <div style="position: relative; top: 35px; width: 200px; text-align: center; font-weight: 700; font-size: 100%; color: rgb(70,146,81);font-family:Arial,"ＭＳ Ｐゴシック", Helvetica, sans-serif,"宋体""><%:MonthCo2.ToString("N0") %>T</div>
            <div style="position: relative; top: 18px; left: 190px; width: 156px; text-align: center; font-weight: 700; font-size: 100%; color: rgb(70,146,81);font-family:Arial,"ＭＳ Ｐゴシック", Helvetica, sans-serif,"宋体""><%:MonthTrees.ToString("N0") %></div>
            <div style="position: relative; top: 185px; width: 200px; text-align: center; font-weight: 700; font-size: 100%;font-family:Arial,"ＭＳ Ｐゴシック", Helvetica, sans-serif,"宋体""><%:Co2.ToString("N0") %>T</div>
            <div style="position: relative; top: 168px; left: 190px; width: 156px; text-align: center; font-weight: 700; font-size: 100%;font-family:Arial,"ＭＳ Ｐゴシック", Helvetica, sans-serif,"宋体""><%:Trees.ToString("N0") %></div>
        </div>
        <div class="floatDiv subContainer" style="padding:0;">
            <div  class="titleBar">
                <div style="float:left;padding-left: 5px;font-size: 1.0em;font-family:微软雅黑;font-weight:700;color:rgba(125,125,125,1);line-height: 24px;">Energy Consumption & Cost</div>
                <a href='#' id="min_enery">
                    <img src="Images/min.png" height="22" alt="最小化" /></a>
                <a href='#' id="max_enery" style="display: none">
                    <img src="Images/max.png" height="22" alt="最大化" /></a>
            </div>
            <table class="energy" id="energy">
              <%--  <caption>Energy Consumption & Cost</caption>--%>
                <colgroup>
                    <col id="cat" />
                    <col id="today" />
                    <col id="wtd" />
                    <col id="mtd" />
                    <col id="ytd" />
                </colgroup>
                <tr class="split" style="line-height: 24px;">
                    <th scope="col"></th>
                    <th scope="col">Today</th>
                    <th scope="col">WTD</th>
                    <th scope="col">MTD</th>
                    <th scope="col">YTD</th>
                </tr>
                <tr>
                    <td class="special">Energy</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Electrictiy(kWh)</td>
                    <td class="content">
                        <asp:Label ID="lbl_Energy_today" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_Energy_wtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_Energy_mtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_Energy_ytd" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Water(m&sup3;)</td>
                    <td class="content">
                        <asp:Label ID="lbl_water_today" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_water_wtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_water_mtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_water_ytd" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Gas(m3)</td>
                    <td class="content">
                        <asp:Label ID="lbl_gas_today" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_gas_wtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_gas_mtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_gas_ytd" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr class="split">
                    <td>LN2(m&sup3;)</td>
                    <td class="content">
                        <asp:Label ID="lbl_ln_today" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_ln_wtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_ln_mtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_ln_ytd" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="special">Cost</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Electrictiy Cost(￥)</td>
                    <td class="content">
                        <asp:Label ID="lbl_Energy_cost_today" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_Energy_cost_wtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_Energy_cost_mtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_Energy_cost_ytd" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Water Cost(￥)</td>
                    <td class="content">
                        <asp:Label ID="lbl_water_cost_today" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_water_cost_wtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_water_cost_mtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_water_cost_ytd" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Gas Cost(￥)</td>
                    <td class="content">
                        <asp:Label ID="lbl_gas_cost_today" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_gas_cost_wtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_gas_cost_mtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_gas_cost_ytd" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>LN2 Cost(￥)</td>
                    <td class="content">
                        <asp:Label ID="lbl_ln_cost_today" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_ln_cost_wtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_ln_cost_mtd" runat="server" Text="0"></asp:Label>
                    </td>
                    <td class="content">
                        <asp:Label ID="lbl_ln_cost_ytd" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
