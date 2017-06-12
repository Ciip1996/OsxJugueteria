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
    public class BitacorasController : ApiController
    {
        private JugueteriaBDEntitiesNew db = new JugueteriaBDEntitiesNew();

        // GET: api/Bitacoras
        public IQueryable<Bitacora> GetBitacoras()
        {
            return db.Bitacoras;
        }

        // GET: api/Bitacoras/5
        [ResponseType(typeof(Bitacora))]
        public IHttpActionResult GetBitacora(long id)
        {
            Bitacora bitacora = db.Bitacoras.Find(id);
            if (bitacora == null)
            {
                return NotFound();
            }

            return Ok(bitacora);
        }

        // PUT: api/Bitacoras/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutBitacora(long id, Bitacora bitacora)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != bitacora.IdBitacora)
            {
                return BadRequest();
            }

            db.Entry(bitacora).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BitacoraExists(id))
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

        // POST: api/Bitacoras
        [ResponseType(typeof(Bitacora))]
        public IHttpActionResult PostBitacora(Bitacora bitacora)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Bitacoras.Add(bitacora);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = bitacora.IdBitacora }, bitacora);
        }

        // DELETE: api/Bitacoras/5
        [ResponseType(typeof(Bitacora))]
        public IHttpActionResult DeleteBitacora(long id)
        {
            Bitacora bitacora = db.Bitacoras.Find(id);
            if (bitacora == null)
            {
                return NotFound();
            }

            db.Bitacoras.Remove(bitacora);
            db.SaveChanges();

            return Ok(bitacora);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool BitacoraExists(long id)
        {
            return db.Bitacoras.Count(e => e.IdBitacora == id) > 0;
        }
    }
}