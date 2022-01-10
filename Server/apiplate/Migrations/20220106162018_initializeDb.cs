using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace apiplate.Migrations
{
    public partial class initializeDb : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Messages",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FullName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Content = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Phone = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Messages", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Permissions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Create = table.Column<bool>(type: "bit", nullable: false),
                    Read = table.Column<bool>(type: "bit", nullable: false),
                    Update = table.Column<bool>(type: "bit", nullable: false),
                    Delete = table.Column<bool>(type: "bit", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Permissions", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    MessagesPermissionsId = table.Column<int>(type: "int", nullable: true),
                    UsersPermissionsId = table.Column<int>(type: "int", nullable: true),
                    RolesPermissionsId = table.Column<int>(type: "int", nullable: true),
                    EventsPermissionsId = table.Column<int>(type: "int", nullable: true),
                    SlidesPermissionsId = table.Column<int>(type: "int", nullable: true),
                    ProgramsPermissionsId = table.Column<int>(type: "int", nullable: true),
                    NewsPermissionsId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Roles", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Roles_Permissions_EventsPermissionsId",
                        column: x => x.EventsPermissionsId,
                        principalTable: "Permissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Roles_Permissions_MessagesPermissionsId",
                        column: x => x.MessagesPermissionsId,
                        principalTable: "Permissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Roles_Permissions_NewsPermissionsId",
                        column: x => x.NewsPermissionsId,
                        principalTable: "Permissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Roles_Permissions_ProgramsPermissionsId",
                        column: x => x.ProgramsPermissionsId,
                        principalTable: "Permissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Roles_Permissions_RolesPermissionsId",
                        column: x => x.RolesPermissionsId,
                        principalTable: "Permissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Roles_Permissions_SlidesPermissionsId",
                        column: x => x.SlidesPermissionsId,
                        principalTable: "Permissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Roles_Permissions_UsersPermissionsId",
                        column: x => x.UsersPermissionsId,
                        principalTable: "Permissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsManager = table.Column<bool>(type: "bit", nullable: false),
                    Image = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    RoleId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true),
                    Username = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Phone = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordHash = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    PasswordSalt = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    Photo = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Users_Roles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "Roles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Activity",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    EffectedTable = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    EffectedRowId = table.Column<int>(type: "int", nullable: false),
                    Action = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    AdminId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Activity", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Activity_Users_AdminId",
                        column: x => x.AdminId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Notification",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Message = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Action = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Module = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Url = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Read = table.Column<bool>(type: "bit", nullable: false),
                    GroupedItem = table.Column<int>(type: "int", nullable: true),
                    AdminId = table.Column<int>(type: "int", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    LastUpdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedBy = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Notification", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Notification_Users_AdminId",
                        column: x => x.AdminId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "CreatedAt", "CreatedBy", "Email", "Image", "IsManager", "LastUpdate", "PasswordHash", "PasswordSalt", "Phone", "Photo", "RoleId", "Username" },
                values: new object[] { 1, new DateTime(2022, 1, 6, 18, 20, 18, 110, DateTimeKind.Local).AddTicks(3773), null, "almunzir99", null, true, new DateTime(2022, 1, 6, 18, 20, 18, 111, DateTimeKind.Local).AddTicks(8221), new byte[] { 165, 2, 55, 83, 223, 245, 222, 223, 164, 107, 65, 159, 237, 100, 82, 6, 180, 144, 156, 105, 155, 177, 108, 80, 49, 236, 219, 255, 86, 151, 159, 224, 52, 210, 237, 50, 70, 46, 218, 19, 29, 23, 4, 79, 241, 74, 185, 237, 4, 212, 15, 163, 151, 166, 31, 120, 104, 199, 107, 196, 246, 233, 21, 154 }, new byte[] { 60, 26, 225, 39, 255, 76, 189, 38, 189, 153, 232, 113, 224, 121, 163, 16, 53, 241, 113, 130, 205, 145, 155, 219, 50, 95, 60, 28, 134, 180, 99, 43, 191, 67, 149, 55, 142, 88, 136, 255, 81, 26, 6, 227, 133, 236, 57, 164, 90, 161, 194, 173, 206, 157, 32, 95, 103, 127, 208, 148, 194, 96, 139, 241, 95, 173, 59, 42, 12, 159, 184, 15, 232, 131, 128, 244, 205, 77, 120, 198, 212, 27, 54, 188, 97, 170, 177, 126, 35, 46, 15, 172, 183, 44, 13, 10, 55, 121, 95, 18, 135, 185, 171, 117, 32, 210, 41, 101, 0, 190, 63, 107, 111, 8, 18, 123, 127, 82, 103, 66, 69, 128, 188, 5, 169, 174, 0, 209 }, "249128647019", null, null, "almunzir99" });

            migrationBuilder.CreateIndex(
                name: "IX_Activity_AdminId",
                table: "Activity",
                column: "AdminId");

            migrationBuilder.CreateIndex(
                name: "IX_Notification_AdminId",
                table: "Notification",
                column: "AdminId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_EventsPermissionsId",
                table: "Roles",
                column: "EventsPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_MessagesPermissionsId",
                table: "Roles",
                column: "MessagesPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_NewsPermissionsId",
                table: "Roles",
                column: "NewsPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_ProgramsPermissionsId",
                table: "Roles",
                column: "ProgramsPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_RolesPermissionsId",
                table: "Roles",
                column: "RolesPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_SlidesPermissionsId",
                table: "Roles",
                column: "SlidesPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_Title",
                table: "Roles",
                column: "Title",
                unique: true,
                filter: "[Title] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Roles_UsersPermissionsId",
                table: "Roles",
                column: "UsersPermissionsId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_RoleId",
                table: "Users",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_Username",
                table: "Users",
                column: "Username",
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Activity");

            migrationBuilder.DropTable(
                name: "Messages");

            migrationBuilder.DropTable(
                name: "Notification");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Roles");

            migrationBuilder.DropTable(
                name: "Permissions");
        }
    }
}
