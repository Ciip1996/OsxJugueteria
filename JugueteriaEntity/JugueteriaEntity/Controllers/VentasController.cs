using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using JugueteriaEntity;

namespace JugueteriaEntity.Controllers
{
    public class VentasController : ApiController
    {
        private JugueteriaBDEntitiesNew db = new JugueteriaBDEntitiesNew();

        // GET: api/Ventas
        public IQueryable<Venta> GetVentas()
        {
            return db.Ventas;
        }

        // GET: api/Ventas/5
        [ResponseType(typeof(Venta))]
        public IHttpActionResult GetVenta(long id)
        {
            Venta venta = db.Ventas.Find(id);
            if (venta == null)
            {
                return NotFound();
            }

            return Ok(venta);
        }

        // PUT: api/Ventas/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutVenta(long id, Venta venta)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != venta.Id)
            {
                return BadRequest();
            }

            db.Entry(venta).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!VentaExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Ventas
        [ResponseType(typeof(Venta))]
        public IHttpActionResult PostVenta(Venta venta)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Ventas.Add(venta);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = venta.Id }, venta);
        }

        // DELETE: api/Ventas/5
        [ResponseType(typeof(Venta))]
        public IHttpActionResult DeleteVenta(long id)
        {
            Venta venta = db.Ventas.Find(id);
            if (venta == null)
            {
                return NotFound();
            }

            db.Ventas.Remove(venta);
            db.SaveChanges();

            return Ok(venta);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool VentaExists(long id)
        {
            return db.Ventas.Count(e => e.Id == id) > 0;
        }
    }
}