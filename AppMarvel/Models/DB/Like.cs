using System;
using System.Collections.Generic;

namespace AppMarvel.Models.DB
{
    public partial class Like
    {
        public int Id { get; set; }
        public int? Codigo { get; set; }
        public string? Name { get; set; }
        public int? Cantidad { get; set; }
        public DateTime? Fecha { get; set; }
    }
}
