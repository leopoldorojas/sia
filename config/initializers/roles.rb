
#Configure RBAC roles and privileges
Rails.application.config.user_roles = {
  superadmin: { privilege: 99 },
  admin: { privilege: 75 }, 
  company_admin: { privilege: 50 },
  company_user: { privilege: 25 }
}