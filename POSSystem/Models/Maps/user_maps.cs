using POSSystem.Models.Tables;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Maps
{
    public class user_maps : EntityTypeConfiguration<tbl_user>
    {
        public user_maps()
        {
            HasKey(x => x.userID);
            ToTable("tbl_user");

          
        }
    }
}