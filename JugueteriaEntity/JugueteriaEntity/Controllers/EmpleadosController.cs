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
    public class EmpleadosController : ApiController
    {
        private JugueteriaBDEntitiesNew db = new JugueteriaBDEntitiesNew();

        // GET: api/Empleados
        public IQueryable<Empleado> GetEmpleadoes()
        {
            return db.Empleadoes;
        }

        // GET: api/Empleados/5
        [ResponseType(typeof(Empleado))]
        public IHttpActionResult GetEmpleado(long id)
        {
            Empleado empleado = db.Empleadoes.Find(id);
            if (empleado == null)
            {
                return NotFound();
            }

            return Ok(empleado);
        }

        // PUT: api/Empleados/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutEmpleado(long id, Empleado empleado)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != empleado.Id)
            {
                return BadRequest();
            }

            db.Entry(empleado).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EmpleadoExists(id))
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

        // POST: api/Empleados
        [ResponseType(typeof(Empleado))]
        public IHttpActionResult PostEmpleado(Empleado empleado)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Empleadoes.Add(empleado);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = empleado.Id }, empleado);
        }

        // DELETE: api/Empleados/5
        [ResponseType(typeof(Empleado))]
        public IHttpActionResult DeleteEmpleado(long id)
        {
            Empleado empleado = db.Empleadoes.Find(id);
            if (empleado == null)
            {
                return NotFound();
            }

            db.Empleadoes.Remove(empleado);
            db.SaveChanges();

            return Ok(empleado);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool EmpleadoExists(long id)
        {
            return db.Empleadoes.Count(e => e.Id == id) > 0;
        }
    }
}