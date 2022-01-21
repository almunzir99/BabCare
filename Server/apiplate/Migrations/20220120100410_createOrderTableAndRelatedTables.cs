using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class createOrderTableAndRelatedTables : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Orders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CustomerId = table.Column<int>(type: "int", nullable: false),
                    BranchId = table.Column<int>(type: "int", nullable: false),
                    DeliveryId = table.Column<int>(type: "int", nullable: true),
                    DeliveryAmount = table.Column<double>(type: "float", nullable: false),
                    Lat = table.Column<double>(type: "float", nullable: false),
                    Long = table.Column<double>(type: "float", nullable: false),
                    Status = table.Column<int>(type: "int", nullable: false),
                    OrderFeedback = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PaymentType = table.Column<int>(type: "int", nullable: false),
                    IsPaid = table.Column<bool>(type: "bit", nullable: false),
                    Total = table.Column<double>(type: "float", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Orders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Orders_Branches_BranchId",
                        column: x => x.BranchId,
                        principalTable: "Branches",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Orders_Customers_CustomerId",
                        column: x => x.CustomerId,
                        principalTable: "Customers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Orders_DeliveryDrivers_DeliveryId",
                        column: x => x.DeliveryId,
                        principalTable: "DeliveryDrivers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "OrderedProducts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OrderId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderedProducts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OrderedProducts_Orders_OrderId",
                        column: x => x.OrderId,
                        principalTable: "Orders",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "OrderedAddons",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AddonIndex = table.Column<int>(type: "int", nullable: false),
                    OrderedProductId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderedAddons", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OrderedAddons_OrderedProducts_OrderedProductId",
                        column: x => x.OrderedProductId,
                        principalTable: "OrderedProducts",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "OrderedOptions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OptionIndex = table.Column<int>(type: "int", nullable: false),
                    OptionValueIndex = table.Column<int>(type: "int", nullable: false),
                    OrderedProductId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OrderedOptions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_OrderedOptions_OrderedProducts_OrderedProductId",
                        column: x => x.OrderedProductId,
                        principalTable: "OrderedProducts",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 20, 12, 4, 8, 958, DateTimeKind.Local).AddTicks(2976), new DateTime(2022, 1, 20, 12, 4, 8, 959, DateTimeKind.Local).AddTicks(4005), new byte[] { 65, 101, 161, 240, 170, 91, 192, 203, 192, 161, 184, 173, 89, 148, 163, 196, 176, 187, 202, 198, 129, 181, 98, 171, 2, 36, 185, 100, 110, 75, 1, 205, 244, 110, 182, 51, 96, 141, 6, 183, 114, 86, 163, 160, 186, 226, 90, 112, 99, 99, 239, 162, 187, 238, 24, 40, 103, 2, 224, 192, 199, 243, 244, 179 }, new byte[] { 57, 141, 182, 199, 9, 221, 58, 68, 204, 177, 168, 121, 16, 189, 130, 240, 242, 121, 5, 88, 139, 74, 161, 162, 15, 110, 73, 248, 139, 5, 174, 65, 247, 163, 192, 48, 50, 25, 88, 188, 126, 215, 231, 203, 50, 214, 108, 144, 153, 158, 41, 8, 42, 5, 32, 249, 67, 210, 158, 38, 163, 166, 21, 25, 126, 91, 41, 196, 102, 74, 85, 88, 54, 102, 156, 136, 22, 194, 133, 46, 157, 212, 19, 206, 178, 5, 116, 214, 80, 35, 241, 136, 80, 207, 9, 152, 46, 90, 55, 31, 111, 157, 228, 83, 205, 238, 56, 190, 159, 43, 164, 140, 183, 33, 207, 91, 129, 14, 139, 237, 2, 159, 238, 143, 39, 3, 5, 181 } });

            migrationBuilder.CreateIndex(
                name: "IX_OrderedAddons_OrderedProductId",
                table: "OrderedAddons",
                column: "OrderedProductId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderedOptions_OrderedProductId",
                table: "OrderedOptions",
                column: "OrderedProductId");

            migrationBuilder.CreateIndex(
                name: "IX_OrderedProducts_OrderId",
                table: "OrderedProducts",
                column: "OrderId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_BranchId",
                table: "Orders",
                column: "BranchId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_CustomerId",
                table: "Orders",
                column: "CustomerId");

            migrationBuilder.CreateIndex(
                name: "IX_Orders_DeliveryId",
                table: "Orders",
                column: "DeliveryId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "OrderedAddons");

            migrationBuilder.DropTable(
                name: "OrderedOptions");

            migrationBuilder.DropTable(
                name: "OrderedProducts");

            migrationBuilder.DropTable(
                name: "Orders");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 15, 18, 31, 34, 458, DateTimeKind.Local).AddTicks(294), new DateTime(2022, 1, 15, 18, 31, 34, 459, DateTimeKind.Local).AddTicks(2318), new byte[] { 0, 15, 253, 158, 102, 196, 69, 54, 175, 161, 227, 4, 81, 174, 25, 167, 32, 27, 106, 2, 18, 74, 252, 8, 223, 223, 198, 165, 176, 245, 39, 239, 116, 28, 152, 219, 217, 54, 21, 111, 18, 7, 155, 95, 246, 185, 42, 64, 57, 119, 237, 127, 72, 93, 231, 28, 247, 74, 99, 127, 232, 116, 110, 211 }, new byte[] { 241, 70, 101, 155, 64, 244, 24, 103, 136, 1, 203, 241, 226, 95, 28, 51, 211, 27, 228, 255, 134, 59, 133, 230, 175, 162, 101, 15, 230, 152, 61, 64, 200, 89, 165, 26, 13, 167, 193, 63, 213, 152, 44, 117, 163, 93, 153, 165, 17, 81, 214, 94, 27, 140, 196, 1, 94, 227, 179, 50, 248, 217, 207, 200, 103, 0, 244, 170, 250, 153, 78, 109, 21, 155, 65, 74, 199, 158, 30, 162, 247, 119, 203, 126, 217, 72, 38, 190, 247, 253, 234, 144, 11, 85, 108, 58, 119, 151, 140, 202, 118, 48, 56, 89, 234, 101, 13, 143, 200, 3, 178, 238, 123, 128, 225, 228, 245, 255, 142, 160, 209, 252, 1, 107, 174, 232, 101, 251 } });
        }
    }
}
