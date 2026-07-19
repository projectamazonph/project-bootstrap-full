# API Specification

## Overview
**Base URL:** `https://api.[domain]/v1`
**Authentication:** [Bearer Token / API Key / OAuth2]
**Format:** JSON
**Version:** 1.0.0

---

## Authentication

### Bearer Token
```http
Authorization: Bearer <token>
```

### API Key (Header)
```http
X-API-Key: <api_key>
```

### OAuth2 Flow
```
POST /oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code
&code=<authorization_code>
&redirect_uri=<redirect_uri>
&client_id=<client_id>
&client_secret=<client_secret>
```

---

## Rate Limiting

### Limits
| Tier | Requests/Minute | Requests/Hour | Burst |
|------|-----------------|---------------|-------|
| Free | 60 | 1,000 | 10 |
| Pro | 300 | 10,000 | 50 |
| Enterprise | 1,000 | 100,000 | 200 |

### Headers
```http
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 45
X-RateLimit-Reset: 1640995200
Retry-After: 30  # Seconds until rate limit resets
```

### Error Response
```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Rate limit exceeded. Retry after 30 seconds.",
    "retry_after": 30
  }
}
```

---

## Common Response Codes

| Code | Description | Usage |
|------|-------------|-------|
| 200 | OK | Successful request |
| 201 | Created | Resource created |
| 204 | No Content | Successful deletion |
| 400 | Bad Request | Invalid parameters |
| 401 | Unauthorized | Invalid/missing auth |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource doesn't exist |
| 409 | Conflict | Resource already exists |
| 422 | Unprocessable | Validation error |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Server Error | Internal error |

---

## Endpoints

### Users

#### List Users
```http
GET /users
```
**Query Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| page | integer | 1 | Page number |
| limit | integer | 20 | Items per page |
| sort | string | created_at | Sort field |
| order | string | desc | Sort order |

**Response:**
```json
{
  "data": [
    {
      "id": "user_123",
      "email": "user@example.com",
      "name": "John Doe",
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "pages": 5
  }
}
```

#### Get User
```http
GET /users/{id}
```

#### Create User
```http
POST /users
Content-Type: application/json

{
  "email": "user@example.com",
  "name": "John Doe",
  "password": "secure_password"
}
```

#### Update User
```http
PUT /users/{id}
Content-Type: application/json

{
  "name": "John Smith"
}
```

#### Delete User
```http
DELETE /users/{id}
```

---

### Projects

#### List Projects
```http
GET /projects
```

#### Get Project
```http
GET /projects/{id}
```

#### Create Project
```http
POST /projects
Content-Type: application/json

{
  "name": "Project Name",
  "description": "Project description"
}
```

---

### Files

#### Upload File
```http
POST /files
Content-Type: multipart/form-data

file: <binary>
metadata: {"name": "file.pdf", "type": "document"}
```

#### Download File
```http
GET /files/{id}/download
```

---

## Error Response Format

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      },
      {
        "field": "password",
        "message": "Password must be at least 8 characters"
      }
    ]
  }
}
```

---

## Pagination

### Query Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| page | integer | 1 | Page number (1-based) |
| limit | integer | 20 | Items per page (max 100) |
| cursor | string | - | Cursor for cursor-based pagination |

### Response Headers
```http
X-Total-Count: 100
X-Page-Count: 5
X-Current-Page: 1
X-Per-Page: 20
Link: <https://api.example.com/users?page=2>; rel="next"
```

---

## Versioning

### URL Versioning
```
https://api.example.com/v1/users
https://api.example.com/v2/users
```

### Header Versioning
```http
Accept-Version: v1
```

### Deprecation Headers
```http
Deprecation: true
Sunset: 2024-12-31T23:59:59Z
Link: <https://api.example.com/v2/docs>; rel="successor-version"
```

---

## Webhooks

### Event Types
| Event | Description |
|-------|-------------|
| user.created | New user registered |
| user.updated | User profile updated |
| project.created | New project created |
| payment.completed | Payment successful |

### Webhook Payload
```json
{
  "id": "evt_123",
  "type": "user.created",
  "created_at": "2024-01-01T00:00:00Z",
  "data": {
    "id": "user_123",
    "email": "user@example.com"
  }
}
```

### Verification
```http
X-Webhook-Signature: sha256=<hmac_signature>
```

---

## OpenAPI/Swagger

Full OpenAPI specification available at:
- `/api-docs` (Swagger UI)
- `/api-docs.json` (OpenAPI JSON)
- `/api-docs.yaml` (OpenAPI YAML)

---

## SDKs & Libraries

| Language | Package | Installation |
|----------|---------|--------------|
| JavaScript | `@company/sdk` | `npm install @company/sdk` |
| Python | `company-sdk` | `pip install company-sdk` |
| Go | `company-go` | `go get github.com/company/sdk-go` |