using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using DotNetEnv;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;


// load env
Env.Load();

var builder = WebApplication.CreateBuilder(args);

builder.Configuration["JwtSettings:SecretKey"] = Environment.GetEnvironmentVariable("JWT_SECRET") ?? throw new Exception("JWT_SECRET not set");
builder.Configuration["JwtSettings:Issuer"] = Environment.GetEnvironmentVariable("JWT_ISSUER") ?? "MyAppBackend";
builder.Configuration["JwtSettings:Audience"] = Environment.GetEnvironmentVariable("JWT_AUDIENCE") ?? "MyAppFlutterClient";
builder.Configuration["JwtSettings:ExpiryMinutes"] = Environment.GetEnvironmentVariable("JWT_EXPIRY") ?? "60";

// Cấu hình JWT
var secretKey = builder.Configuration["JwtSettings:SecretKey"];
var issuer = builder.Configuration["JwtSettings:Issuer"];
var audience = builder.Configuration["JwtSettings:Audience"];

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = issuer,
        ValidAudience = audience,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey))
    };
});

//  THÊM CORS SERVICE
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFlutter",
        policy =>
        {
            policy.WithOrigins(
                    "http://localhost:*",
                    "http://127.0.0.1:*",
                    "http://10.0.2.2:*"
            )
                .AllowAnyHeader()
                .AllowAnyMethod()
                .AllowCredentials();
        });
});

// Các service registrations hiện có
builder.Services.Scan(scan => scan
    .FromAssemblies(
        typeof(Application.Service.RoleService).Assembly,
        typeof(Infrastructure.Repositories.RoleRepository).Assembly,
        typeof(Application.Service.LoginServices).Assembly
    )
    .AddClasses(classes => classes.Where(type =>
        type.Name.EndsWith("Service") ||
        type.Name.EndsWith("Services") ||
        type.Name.EndsWith("Repository")
        ))
    .AsImplementedInterfaces()
    .WithScopedLifetime()
);
builder.Services.AddScoped<LessonDeltaAssembler>();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped<IJwtService, JwtService>();

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowFlutter");
app.UseAuthorization();
app.MapControllers();

app.Run();