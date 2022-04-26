using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class addStatusHistoryToOrder : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "OrderFeedback",
                table: "Orders");

            migrationBuilder.CreateTable(
                name: "StatusHistory",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Status = table.Column<int>(type: "int", nullable: false),
                    Comment = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    OrderId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StatusHistory", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StatusHistory_Orders_OrderId",
                        column: x => x.OrderId,
                        principalTable: "Orders",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 4, 26, 4, 48, 15, 173, DateTimeKind.Local).AddTicks(6132), new DateTime(2022, 4, 26, 4, 48, 15, 174, DateTimeKind.Local).AddTicks(6445), new byte[] { 82, 8, 134, 136, 253, 146, 203, 0, 248, 65, 252, 215, 204, 65, 28, 24, 231, 48, 33, 44, 101, 187, 112, 135, 20, 135, 3, 207, 26, 142, 44, 47, 26, 223, 163, 200, 4, 5, 216, 234, 250, 1, 145, 65, 70, 122, 165, 222, 93, 121, 13, 185, 232, 21, 210, 101, 89, 65, 46, 228, 110, 102, 173, 117 }, new byte[] { 36, 121, 147, 33, 35, 78, 192, 201, 54, 227, 82, 153, 41, 39, 197, 41, 189, 185, 193, 143, 77, 255, 123, 159, 209, 190, 113, 44, 31, 195, 7, 208, 239, 103, 217, 59, 207, 203, 13, 27, 211, 146, 104, 95, 164, 189, 129, 241, 227, 0, 42, 240, 2, 11, 63, 119, 14, 221, 195, 79, 94, 254, 64, 140, 123, 196, 91, 29, 94, 14, 28, 30, 218, 205, 63, 110, 221, 73, 102, 218, 193, 19, 210, 29, 223, 2, 27, 104, 125, 56, 153, 92, 49, 191, 111, 43, 60, 185, 35, 134, 149, 75, 39, 239, 21, 133, 233, 40, 146, 6, 222, 37, 148, 185, 228, 239, 152, 104, 201, 54, 219, 198, 140, 8, 230, 213, 210, 40 } });

            migrationBuilder.CreateIndex(
                name: "IX_StatusHistory_OrderId",
                table: "StatusHistory",
                column: "OrderId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "StatusHistory");

            migrationBuilder.AddColumn<string>(
                name: "OrderFeedback",
                table: "Orders",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 3, 28, 14, 50, 15, 489, DateTimeKind.Local).AddTicks(1107), new DateTime(2022, 3, 28, 14, 50, 15, 495, DateTimeKind.Local).AddTicks(3145), new byte[] { 246, 57, 186, 57, 238, 145, 192, 39, 17, 162, 110, 11, 204, 208, 90, 235, 55, 153, 155, 122, 170, 164, 10, 116, 145, 240, 152, 169, 172, 28, 162, 222, 198, 80, 163, 13, 31, 237, 90, 245, 129, 170, 106, 36, 125, 140, 211, 206, 106, 61, 75, 14, 149, 40, 248, 79, 48, 29, 139, 140, 3, 129, 252, 11 }, new byte[] { 134, 126, 65, 243, 69, 205, 33, 108, 35, 121, 99, 191, 163, 215, 207, 179, 93, 174, 245, 121, 71, 188, 147, 157, 13, 48, 161, 2, 115, 64, 114, 2, 240, 102, 254, 139, 196, 43, 124, 124, 211, 10, 63, 36, 151, 221, 141, 23, 193, 67, 139, 29, 79, 129, 95, 79, 66, 166, 82, 22, 148, 93, 123, 187, 182, 3, 70, 89, 146, 97, 251, 229, 242, 64, 169, 202, 168, 163, 71, 8, 1, 31, 233, 86, 29, 66, 2, 150, 58, 45, 136, 251, 192, 19, 100, 92, 234, 240, 154, 202, 29, 102, 193, 52, 28, 46, 159, 232, 68, 86, 145, 186, 249, 141, 113, 150, 138, 154, 198, 22, 63, 17, 247, 176, 172, 205, 217, 205 } });
        }
    }
}
