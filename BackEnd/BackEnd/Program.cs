using BackEnd.Hubs;
using BackEnd.Models;
using System.Text.Json.Serialization;

namespace BackEnd
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
            builder.Services.AddSignalR(options =>
            {
                options.EnableDetailedErrors = true;
            });
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("_myAllowSpecificOrigins",
                    builder =>
                    {
                        builder.AllowAnyOrigin()
                               .AllowAnyHeader()
                               .AllowAnyMethod()
                               .SetIsOriginAllowed((x) => true)
                               .AllowCredentials();
                    });
            });
            builder.Services.AddDbContext<ChatAppOneToOneContext>();
            builder.Services.AddControllers().AddJsonOptions(x =>
                x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);


            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseCors("_myAllowSpecificOrigins");
            app.UseHttpsRedirection();



            app.UseAuthorization();


            app.UseRouting();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
                endpoints.MapHub<ChatHub>("/chatsocket");



            });
            //app.MapControllers();



            app.Run();
        }
    }
}


//Scaffold-DbContext "Server=PC0577\MSSQL2019;Database=ChatApp_oneToOne;Trusted_Connection=True;TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models