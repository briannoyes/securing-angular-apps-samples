
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;

PRINT N'Creating [dbo].[Milestones]...';


GO
CREATE TABLE [dbo].[Milestones] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [MilestoneStatusId] INT            NOT NULL,
    [Name]              NVARCHAR (MAX) NULL,
    [ProjectId]         INT            NOT NULL,
    CONSTRAINT [PK_Milestones] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Milestones].[IX_Milestones_ProjectId]...';


GO
CREATE NONCLUSTERED INDEX [IX_Milestones_ProjectId]
    ON [dbo].[Milestones]([ProjectId] ASC);


GO
PRINT N'Creating [dbo].[MilestoneStatuses]...';


GO
CREATE TABLE [dbo].[MilestoneStatuses] (
    [Id]   INT            IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_MilestoneStatuses] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Projects]...';


GO
CREATE TABLE [dbo].[Projects] (
    [Id]   INT            IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[UserPermissions]...';


GO
CREATE TABLE [dbo].[UserPermissions] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [ProjectId]     INT            NULL,
    [UserProfileId] NVARCHAR (450) NULL,
    [Value]         NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_UserPermissions] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[UserPermissions].[IX_UserPermissions_ProjectId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserPermissions_ProjectId]
    ON [dbo].[UserPermissions]([ProjectId] ASC);


GO
PRINT N'Creating [dbo].[UserPermissions].[IX_UserPermissions_UserProfileId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserPermissions_UserProfileId]
    ON [dbo].[UserPermissions]([UserProfileId] ASC);


GO
PRINT N'Creating [dbo].[UserProfiles]...';


GO
CREATE TABLE [dbo].[UserProfiles] (
    [Id]          NVARCHAR (450) NOT NULL,
    [Email]       NVARCHAR (MAX) NULL,
    [FirstName]   NVARCHAR (MAX) NULL,
    [HasLoggedIn] BIT            NOT NULL,
    [LastName]    NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_UserProfiles] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[FK_Milestones_Projects_ProjectId]...';


GO
ALTER TABLE [dbo].[Milestones] WITH NOCHECK
    ADD CONSTRAINT [FK_Milestones_Projects_ProjectId] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Projects] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_UserPermissions_Projects_ProjectId]...';


GO
ALTER TABLE [dbo].[UserPermissions] WITH NOCHECK
    ADD CONSTRAINT [FK_UserPermissions_Projects_ProjectId] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Projects] ([Id]);


GO
PRINT N'Creating [dbo].[FK_UserPermissions_UserProfiles_UserProfileId]...';


GO
ALTER TABLE [dbo].[UserPermissions] WITH NOCHECK
    ADD CONSTRAINT [FK_UserPermissions_UserProfiles_UserProfileId] FOREIGN KEY ([UserProfileId]) REFERENCES [dbo].[UserProfiles] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO

ALTER TABLE [dbo].[Milestones] WITH CHECK CHECK CONSTRAINT [FK_Milestones_Projects_ProjectId];

ALTER TABLE [dbo].[UserPermissions] WITH CHECK CHECK CONSTRAINT [FK_UserPermissions_Projects_ProjectId];

ALTER TABLE [dbo].[UserPermissions] WITH CHECK CHECK CONSTRAINT [FK_UserPermissions_UserProfiles_UserProfileId];


GO


SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

BEGIN TRANSACTION
ALTER TABLE [dbo].[Milestones] DROP CONSTRAINT [FK_Milestones_Projects_ProjectId]
ALTER TABLE [dbo].[UserPermissions] DROP CONSTRAINT [FK_UserPermissions_Projects_ProjectId]
ALTER TABLE [dbo].[UserPermissions] DROP CONSTRAINT [FK_UserPermissions_UserProfiles_UserProfileId]
SET IDENTITY_INSERT [dbo].[Projects] ON
INSERT INTO [dbo].[Projects] ([Id], [Name]) VALUES (4, N'Improve Ops Efficiency')
INSERT INTO [dbo].[Projects] ([Id], [Name]) VALUES (5, N'Grow Domestic Sales')
INSERT INTO [dbo].[Projects] ([Id], [Name]) VALUES (9, N'Test Project')
INSERT INTO [dbo].[Projects] ([Id], [Name]) VALUES (10, N'Consolidate Chicago Offices')
SET IDENTITY_INSERT [dbo].[Projects] OFF
SET IDENTITY_INSERT [dbo].[UserPermissions] ON
INSERT INTO [dbo].[UserPermissions] ([Id], [ProjectId], [UserProfileId], [Value]) VALUES (1, NULL, N'151dba72-2400-43d6-9e33-cadbb71b865b', N'Admin')
INSERT INTO [dbo].[UserPermissions] ([Id], [ProjectId], [UserProfileId], [Value]) VALUES (7, 9, N'510df9ac-baca-43b6-9e4a-cdda5f419428', N'Edit')
INSERT INTO [dbo].[UserPermissions] ([Id], [ProjectId], [UserProfileId], [Value]) VALUES (8, 4, N'510df9ac-baca-43b6-9e4a-cdda5f419428', N'View')
INSERT INTO [dbo].[UserPermissions] ([Id], [ProjectId], [UserProfileId], [Value]) VALUES (9, 10, N'510df9ac-baca-43b6-9e4a-cdda5f419428', N'Edit')
INSERT INTO [dbo].[UserPermissions] ([Id], [ProjectId], [UserProfileId], [Value]) VALUES (10, 10, N'34a2101b-3f25-4a2d-87d2-ca7adb3feb11', N'View')
SET IDENTITY_INSERT [dbo].[UserPermissions] OFF
INSERT INTO [dbo].[UserProfiles] ([Id], [Email], [FirstName], [HasLoggedIn], [LastName]) VALUES (N'151dba72-2400-43d6-9e33-cadbb71b865b', N'admin@globomantics.com', N'Brian', 0, N'Noyes')
INSERT INTO [dbo].[UserProfiles] ([Id], [Email], [FirstName], [HasLoggedIn], [LastName]) VALUES (N'34a2101b-3f25-4a2d-87d2-ca7adb3feb11', N'bob@globomantics.com', N'Bob', 0, N'Roberts')
INSERT INTO [dbo].[UserProfiles] ([Id], [Email], [FirstName], [HasLoggedIn], [LastName]) VALUES (N'510df9ac-baca-43b6-9e4a-cdda5f419428', N'alice@globomantics.com', N'Alice', 0, N'Allison')
INSERT INTO [dbo].[UserProfiles] ([Id], [Email], [FirstName], [HasLoggedIn], [LastName]) VALUES (N'91dd93b1-403c-4913-b7fe-917bb0c35996', N'mary@globomantics.com', N'Mary', 0, N'Marisette')
SET IDENTITY_INSERT [dbo].[Milestones] ON
INSERT INTO [dbo].[Milestones] ([Id], [MilestoneStatusId], [Name], [ProjectId]) VALUES (6, 3, N'Conduct Store Closings', 4)
INSERT INTO [dbo].[Milestones] ([Id], [MilestoneStatusId], [Name], [ProjectId]) VALUES (7, 4, N'Implement Lean Phase', 4)
INSERT INTO [dbo].[Milestones] ([Id], [MilestoneStatusId], [Name], [ProjectId]) VALUES (8, 1, N'Outsource Printing', 4)
INSERT INTO [dbo].[Milestones] ([Id], [MilestoneStatusId], [Name], [ProjectId]) VALUES (9, 1, N'Implement CRM', 5)
INSERT INTO [dbo].[Milestones] ([Id], [MilestoneStatusId], [Name], [ProjectId]) VALUES (10, 4, N'Create Tech Sales Role', 5)
INSERT INTO [dbo].[Milestones] ([Id], [MilestoneStatusId], [Name], [ProjectId]) VALUES (13, 4, N'Hire more staff!', 9)
SET IDENTITY_INSERT [dbo].[Milestones] OFF
SET IDENTITY_INSERT [dbo].[MilestoneStatuses] ON
INSERT INTO [dbo].[MilestoneStatuses] ([Id], [Name]) VALUES (1, N'Not Started')
INSERT INTO [dbo].[MilestoneStatuses] ([Id], [Name]) VALUES (2, N'Behind Schedule')
INSERT INTO [dbo].[MilestoneStatuses] ([Id], [Name]) VALUES (3, N'Completed')
INSERT INTO [dbo].[MilestoneStatuses] ([Id], [Name]) VALUES (4, N'On Track')
SET IDENTITY_INSERT [dbo].[MilestoneStatuses] OFF
ALTER TABLE [dbo].[Milestones]
    ADD CONSTRAINT [FK_Milestones_Projects_ProjectId] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Projects] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[UserPermissions]
    ADD CONSTRAINT [FK_UserPermissions_Projects_ProjectId] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Projects] ([Id])
ALTER TABLE [dbo].[UserPermissions]
    ADD CONSTRAINT [FK_UserPermissions_UserProfiles_UserProfileId] FOREIGN KEY ([UserProfileId]) REFERENCES [dbo].[UserProfiles] ([Id])
COMMIT TRANSACTION
PRINT N'Update complete.';


GO