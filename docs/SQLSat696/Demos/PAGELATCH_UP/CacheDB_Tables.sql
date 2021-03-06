-- Sample code inspired by the contributions from the bwin team (https://blogs.msdn.microsoft.com/sqlcat/2016/10/26/how-bwin-is-using-sql-server-2016-in-memory-oltp-to-achieve-unprecedented-performance-and-scale/)
-- The bwin team had provided the scripts here: http://www.mrc.at/Files/CacheDB.zip

USE pfscontention
GO
/****** Object:  Table [dbo].[CacheItems]    Script Date: 8/16/2017 9:41:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CacheItems]
(
	[Key] [nvarchar](256) COLLATE Latin1_General_100_BIN2 NOT NULL,
	[Value] [varbinary](max) NOT NULL,
	[IsSlidingExpiration] [bit] NOT NULL,
	[SlidingIntervalInSeconds] [int] NULL,

 CONSTRAINT [pk_CacheItems]  PRIMARY KEY NONCLUSTERED HASH 
(
	[Key]
)WITH ( BUCKET_COUNT = 16777216)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [dbo].[CacheItems_Expiration]    Script Date: 8/16/2017 9:41:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CacheItems_Expiration]
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](256) COLLATE Latin1_General_100_BIN2 NOT NULL,
	[Expiration] [datetime2](2) NOT NULL,

INDEX [idx_hash_key] NONCLUSTERED HASH 
(
	[Key]
)WITH ( BUCKET_COUNT = 16777216),
 CONSTRAINT [pk_CacheItems_Expiration]  PRIMARY KEY NONCLUSTERED HASH 
(
	[Id]
)WITH ( BUCKET_COUNT = 16777216)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO

/*
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE. 

This sample code is not supported under any Microsoft standard support program or service.  
The entire risk arising out of the use or performance of the sample scripts and documentation remains with you.  
In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts 
be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, 
business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability 
to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages. 
*/
