using POSSystem.Models.Tables;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Web;

namespace POSSystem.Models.Maps
{
    public class order_maps : EntityTypeConfiguration<tbl_order>
    {
        public order_maps()
        {
            HasKey(x => x.orderID);
            ToTable("tbl_order");

         
        }
    }
}