Web → Application → Infrastructure → Core
     (không được phép đi ngược lại)


Rules cho Core:
✅ Không phụ thuộc vào bất kỳ layer nào khác
✅ Chỉ chứa interfaces, không có implementations
✅ Entities không có data annotations của EF Core
src/Core/
├── Entities/           # Domain models
├── Enums/             # Enumerations
├── Exceptions/        # Custom exceptions
├── Interfaces/        # Repository & Service contracts
├── DTOs/             # Data Transfer Objects
└── Common/           # Shared utilities, constants


Rules cho Web:
✅ Chỉ reference Application và Core
✅ Không chứa business logic
✅ Focus trên HTTP concerns
src/Web/
├── Controllers/       # Minimal APIs hoặc Controller-based
├── Endpoints/         # Endpoint definitions
├── Middlewares/       # Custom middlewares
├── Extensions/        # Service configurations
├── Program.cs
└── Web.csproj


Rules cho Application:
✅ Chỉ reference Core layer
✅ Mỗi feature độc lập, có thể test riêng
✅ Sử dụng CQRS pattern với MediatR
src/Application/
├── Features/          # Tổ chức theo feature (CQRS)
│   ├── Courses/
│   │   ├── Commands/
│   │   ├── Queries/
│   │   └── Validators/
│   └── Users/
├── Common/
│   ├── Behaviors/    # MediatR pipelines
│   ├── Interfaces/   # Application services
│   ├── Mappings/     # AutoMapper profiles
│   └── Models/       # Application-specific models
└── Application.csproj


Rules cho Infrastructure:
✅ Implement interfaces từ Core
✅ Chứa tất cả implementations
✅ Có thể reference Core và Application
src/Infrastructure/
├── Data/
│   ├── Configurations/    # EF Core configurations
│   ├── Migrations/        # Database migrations
│   ├── Repositories/      # Repository implementations
│   └── AppDbContext.cs
├── Identity/              # Authentication & Authorization
├── Services/              # External services (Email, Storage)
├── Logging/               # Serilog, logging providers
└── Infrastructure.csproj

