using System.Threading.Tasks;
using AppMarvel.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using AppMarvel.Datos;
//using AppMarvel.Models.DB;

namespace AppMarvel.Controllers
{
    public class HomeController : Controller
    {
        Likedb dbop = new Likedb();
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            List<Models.DB.Top5> lst = new List<Models.DB.Top5>();
                using (var db = new Models.DB.marvelContext())
                {
                    lst = (from d in db.Top5s
                           select new Models.DB.Top5
                           {
                               //Codigo = d.Codigo,
                               Name = d.Name,
                               Cantidad=d.Cantidad


                           }).ToList();
                }
                return View(lst);
        }

        public IActionResult Acerca()
        {
            return View();
        }

        public IActionResult Catalogo()
        {

           
                List<Models.DB.ConteoHeroe> lst = new List<Models.DB.ConteoHeroe>();
                using (var db = new Models.DB.marvelContext())
                {
                    lst = (from d in db.ConteoHeroes
                           select new Models.DB.ConteoHeroe
                           {
                               Codigo = d.Codigo,
                               Name = d.Name,
                               Cantidad = d.Cantidad

                           }).ToList();
                }
                return View(lst);
          
        }
        [HttpPost]
        public IActionResult Catalogo(Like codigo)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    //string res = dbop.Guardar(codigo);
                    //TempData["msg"] = res;
                }
                return View();
            }
            catch (Exception ex)
            {

                TempData["msg"] = ex.Message;
                return View();
            }
            ; 
        }
       /*public IActionResult Catalogo([Bind] Like emp) {
            
            return View();
        }*/


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}