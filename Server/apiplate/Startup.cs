using System.Text;
using apiplate.DataBase;
using apiplate.Domain.Services;
using apiplate.Hubs;
using apiplate.Hubs.Connections;
using apiplate.Services;
using apiplate.Services.ContentManagement;
using apiplate.Services.FilesManager;
using apiplate.StartupTasks;
using apiplate.StartupTasks.Extensions;
using apiplate.Utils;
using apiplate.Utils.SMTP.Services;
using apiplate.Utils.URI;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SpaServices.AngularCli;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using Studious.Domain.Services;

namespace apiplate
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddAutoMapper(typeof(Startup));
            services.AddHttpContextAccessor();
            ConfigureJwtAuthentication(ref services);
            services.AddScoped<IUriService>(o =>
            {
                var accessor = o.GetRequiredService<IHttpContextAccessor>();
                var request = accessor.HttpContext.Request;
                var uri = string.Concat(request.Scheme, "://", request.Host.ToUriComponent());
                return new UriService(uri);
            });
            services.AddScoped<IFilesManagerService, FilesManagerService>();
            services.AddScoped<IAdminService, AdminService>();
            services.AddScoped<ICustomerService, CustomerService>();
            services.AddScoped<IDeliveryService, DeliveryService>();
            services.AddScoped<IRolesService, RolesService>();
            services.AddScoped<IContentManagementService, ContentManagementService>();
            services.AddScoped<IMessagesService, MessageService>();
            services.AddScoped<IProductsService, ProductsService>();
            services.AddScoped<ICategoriesService, CategoriesService>();
            services.AddScoped<IOptionsService, OptionsService>();
            services.AddScoped<IAddOnsService, AddOnsService>();
            services.AddScoped<IBranchesService, BranchesService>();
            services.AddScoped<IOrderService, OrderService>();
            services.AddScoped<IOffersService, OffersService>();
            services.AddScoped<IStatisticsService,StatisticsService>();
            services.AddScoped<IConnectionsManager,ConnectionsManager>();
            services.AddScoped<INotificationService,NotificationService>();
            services.AddStartupTask<ImagesStartupTask>();
            services.AddSingleton<IConfiguration>(Configuration);
            services.AddCors(options =>
       {
           options.AddPolicy("CorsPolicy",
               builder => builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader());
       });
            services.AddScoped<ISMTPService, SMTPService>(option =>
                {
                    var port = Configuration.GetValue<int>("Smtp:port");
                    var host = Configuration.GetValue<string>("Smtp:host");
                    var username = Configuration.GetValue<string>("Smtp:username");
                    var password = Configuration.GetValue<string>("Smtp:password");
                    return new SMTPService(host, port, username, password);
                });
            services.AddSignalR();
            services.AddControllersWithViews().AddNewtonsoftJson(opts =>
            {
                opts.SerializerSettings.DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Utc;
                opts.SerializerSettings.DateFormatString = "yyyy'-'MM'-'dd' T 'HH':'mm':'ss";
            });
            services.AddDbContext<ApiplateDbContext>(option =>
            {
                option.UseSqlServer(Configuration.GetConnectionString("localDb"));
            });
            services.Configure<SecretKey>(Configuration.GetSection("SecretKey"));
            // In production, the Angular files will be served from this directory
            services.AddSpaStaticFiles(configuration =>
            {
                configuration.RootPath = "ClientApp/dist";
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, ICorsService corsService, ICorsPolicyProvider corsPolicyProvider)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles(new StaticFileOptions
            {
                ServeUnknownFileTypes = true,
                OnPrepareResponse = (ctx) =>
                {
                    var policy = corsPolicyProvider.GetPolicyAsync(ctx.Context, "CorsPolicy")
                        .ConfigureAwait(false)
                        .GetAwaiter().GetResult();

                    var corsResult = corsService.EvaluatePolicy(ctx.Context, policy);

                    corsService.ApplyResult(corsResult, ctx.Context.Response);
                }
            });
            if (!env.IsDevelopment())
            {
                app.UseSpaStaticFiles();
            }

            app.UseRouting();
            app.UseCors("CorsPolicy");
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller}/{action=Index}/{id?}");
                endpoints.MapHub<SignalRHub>("/signalRHub");
            });

            app.UseSpa(spa =>
            {
                // To learn more about options for serving an Angular SPA from ASP.NET Core,
                // see https://go.microsoft.com/fwlink/?linkid=864501

                spa.Options.SourcePath = "ClientApp";

                if (env.IsDevelopment())
                {
                    spa.UseAngularCliServer(npmScript: "start");
                }
            });
        }
        public void ConfigureJwtAuthentication(ref IServiceCollection services)
        {
            var secretKeyConfig = Configuration.GetValue<string>("SecretKey:key");
            var key = Encoding.ASCII.GetBytes(secretKeyConfig);
            services.AddAuthentication(o =>
            {
                o.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                o.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(o =>
            {
                o.SaveToken = true;
                o.RequireHttpsMetadata = false;
                o.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false
                };
            })
            ;

        }
    }
}
