using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class createBranchTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Branches",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Location = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Lat = table.Column<double>(type: "float", nullable: false),
                    Long = table.Column<double>(type: "float", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Branches", x => x.Id);
                });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 15, 15, 37, 16, 89, DateTimeKind.Local).AddTicks(8015), new DateTime(2022, 1, 15, 15, 37, 16, 92, DateTimeKind.Local).AddTicks(5765), new byte[] { 207, 197, 43, 178, 230, 244, 7, 101, 25, 228, 80, 127, 110, 38, 174, 72, 207, 26, 147, 246, 19, 43, 196, 28, 103, 122, 168, 203, 113, 75, 41, 111, 213, 182, 45, 88, 152, 230, 107, 58, 64, 239, 89, 112, 2, 64, 211, 216, 118, 195, 208, 173, 226, 51, 36, 177, 115, 215, 22, 24, 123, 165, 214, 247 }, new byte[] { 87, 138, 140, 30, 33, 174, 253, 37, 103, 64, 211, 43, 173, 185, 76, 64, 194, 220, 82, 9, 116, 40, 81, 229, 237, 92, 248, 66, 39, 111, 24, 151, 103, 98, 66, 203, 159, 179, 187, 110, 95, 27, 210, 114, 74, 92, 36, 8, 64, 143, 193, 38, 150, 177, 237, 185, 6, 152, 41, 17, 181, 250, 61, 145, 101, 52, 115, 181, 125, 27, 20, 14, 120, 29, 145, 61, 88, 39, 143, 188, 76, 213, 85, 254, 60, 236, 72, 250, 244, 167, 29, 255, 200, 217, 50, 166, 38, 66, 69, 159, 186, 62, 33, 11, 34, 212, 169, 61, 161, 184, 48, 96, 70, 233, 70, 125, 250, 239, 96, 190, 212, 79, 13, 69, 52, 31, 209, 137 } });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Branches");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "LastUpdate", "PasswordHash", "PasswordSalt" },
                values: new object[] { new DateTime(2022, 1, 12, 19, 57, 7, 446, DateTimeKind.Local).AddTicks(9203), new DateTime(2022, 1, 12, 19, 57, 7, 448, DateTimeKind.Local).AddTicks(8), new byte[] { 186, 30, 165, 48, 216, 119, 218, 79, 221, 234, 18, 95, 175, 238, 100, 72, 176, 240, 151, 88, 103, 182, 51, 175, 180, 221, 241, 95, 9, 243, 227, 100, 79, 108, 71, 182, 201, 143, 170, 9, 130, 48, 140, 218, 105, 20, 176, 10, 184, 189, 181, 194, 2, 86, 237, 177, 26, 49, 167, 21, 203, 146, 147, 224 }, new byte[] { 5, 99, 187, 34, 80, 33, 67, 252, 116, 147, 201, 158, 179, 29, 12, 93, 33, 204, 203, 146, 143, 107, 213, 156, 229, 233, 56, 123, 217, 146, 19, 189, 87, 167, 199, 219, 224, 235, 207, 203, 118, 123, 56, 247, 130, 186, 70, 59, 174, 0, 49, 183, 152, 255, 63, 158, 57, 222, 24, 150, 205, 2, 27, 238, 107, 254, 199, 76, 209, 74, 222, 173, 151, 91, 103, 54, 185, 75, 128, 138, 188, 173, 108, 236, 234, 136, 139, 30, 18, 19, 99, 0, 242, 103, 76, 65, 150, 131, 60, 2, 49, 66, 92, 56, 26, 55, 240, 54, 138, 33, 88, 206, 12, 67, 243, 101, 68, 208, 80, 123, 78, 197, 93, 218, 136, 181, 159, 181 } });
        }
    }
}
