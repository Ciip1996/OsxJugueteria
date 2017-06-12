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
    public class DetalleVentasController : ApiController
    {
        private JugueteriaBDEntitiesNew db = new JugueteriaBDEntitiesNew();

        // GET: api/DetalleVentas
        public IQueryable<DetalleVenta> GetDetalleVentas()
        {
            return db.DetalleVentas;
        }

        // GET: api/DetalleVentas/5
        [ResponseType(typeof(DetalleVenta))]
        public IHttpActionResult GetDetalleVenta(long id)
        {
            DetalleVenta detalleVenta = db.DetalleVentas.Find(id);
            if (detalleVenta == null)
            {
                return NotFound();
            }

            return Ok(detalleVenta);
        }

        // PUT: api/DetalleVentas/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutDetalleVenta(long id, DetalleVenta detalleVenta)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != detalleVenta.IdDetalleVenta)
            {
                return BadRequest();
            }

            db.Entry(detalleVenta).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DetalleVentaExists(id))
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

        // POST: api/DetalleVentas
        [ResponseType(typeof(DetalleVenta))]
        public IHttpActionResult PostDetalleVenta(DetalleVenta detalleVenta)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.DetalleVentas.Add(detalleVenta);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = detalleVenta.IdDetalleVenta }, detalleVenta);
        }

        // DELETE: api/DetalleVentas/5
        [ResponseType(typeof(DetalleVenta))]
        public IHttpActionResult DeleteDetalleVenta(long id)
        {
            DetalleVenta detalleVenta = db.DetalleVentas.Find(id);
            if (detalleVenta == null)
            {
                return NotFound();
            }

            db.DetalleVentas.Remove(detalleVenta);
            db.SaveChanges();

            return Ok(detalleVenta);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool DetalleVentaExists(long id)
        {
            return db.DetalleVentas.Count(e => e.IdDetalleVenta == id) > 0;
        }
    }
}