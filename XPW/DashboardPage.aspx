<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DashboardPage.aspx.cs" Inherits="XPW.DashboardPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#min').click(function () {
                $('#div_chart').hide(500);
                $('#max').show(200);
                $(this).hide(200);
            });
            $('#max').click(function() {
                $('#div_chart').show(500);
                $(this).hide(200);
                $('#min').show(200);
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="floatDiv leftWidth">
            <img src="Images/sd.png" />
        </div>
        <div class="floatDiv">
            <div>
                <asp:LinkButton ID="lnk_Water" runat="server" CommandArgument="373" OnClick="OnLinkClick">水</asp:LinkButton>
                <asp:LinkButton ID="lnk_elctr" runat="server" CommandArgument="388" OnClick="OnLinkClick">电</asp:LinkButton>
                <asp:LinkButton ID="lnk_Lng" runat="server" CommandArgument="358" OnClick="OnLinkClick">煤</asp:LinkButton>
                <a href='#' id="min">最小化</a>
                <a href='#' id="max" style="display: none">最大化</a>
            </div>
            <div id="div_chart">
                <asp:Chart ID="chartEnerge" runat="server" Width="560px" Palette="BrightPastel" ImageType="Png" BorderlineDashStyle="Solid" BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2" BackColor="#D3DFF0" BorderColor="26, 59, 105" OnClick="OnChartClick">
                    <%--<Legends>
                    <asp:Legend Name="Default" Docking="Bottom">
                    </asp:Legend>
                </Legends>--%>
                    <BorderSkin SkinStyle="Emboss" />
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid" BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False" WallWidth="0" IsClustered="False"></Area3DStyle>
                            <AxisY LineColor="64, 64, 64, 64">
                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisY>
                            <AxisX LineColor="64, 64, 64, 64">
                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisX>
                        </asp:ChartArea>
                    </ChartAreas>

                </asp:Chart>
            </div>
        </div>
    </div>
    <div style="clear: both;">
        <div class="floatDiv leftWidth co2">
            <div style="position: relative; top: 210px; width: 156px; text-align: center; font-weight: 700; font-size: 100%"><%:Co2 %>T</div>
            <div style="position: relative; top: 190px; left: 170px; width: 156px; text-align: center; font-weight: 700; font-size: 100%"><%:Trees %></div>
        </div>
        <div class="floatDiv">
            <table class="energy">
                <caption>Energy Consumption & Cost</caption>
                <colgroup>
                    <col id="cat" />
                    <col id="today" />
                    <col id="wtd" />
                    <col id="mtd" />
                    <col id="ytd" />
                </colgroup>
                <tr class="split">
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
                    <td>Electrictiy(KWH)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Water(m3)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Gas(m3)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr class="split">
                    <td>LN2(m3)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
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
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Water Cost(￥)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Gas Cost(￥)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>LN2 Cost(￥)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
