using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using AppMarvel.Models.DB;
//using AppMarvel.Models;

namespace AppMarvel.Datos
{
    public class Likedb
    {
        //SqlConnection con = new SqlConnection("Data Source=(TU); Initial Catalog=marvel;Integrated Security=true");

        public bool Guardar(Like ocodigo)
        {
            bool rpta;
            try
            {
                var cn = new Conexion();
                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("sp_like_add", conexion);
                    cmd.Parameters.AddWithValue("codigo",ocodigo.Codigo);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.ExecuteNonQuery();
                }
                rpta = true;


            }
            catch (Exception e)
            {
                string error = e.Message;
                rpta = false;
            }
            return rpta;
        }



    }
}
