using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Data;
using System.Linq.Expressions;

namespace CollectorsClub.Model.Infrastructure {
	public abstract class RepositoryBase<T> where T : class {
		private CollectorsClubEntities dataContext;

		private readonly IDbSet<T> dbset;
		protected RepositoryBase(IDatabaseFactory databaseFactory) {
			DatabaseFactory = databaseFactory;
			dbset = DataContext.Set<T>();
		}

		protected IDatabaseFactory DatabaseFactory {
			get;
			private set;
		}

		public CollectorsClubEntities DataContext {
			get { return dataContext ?? (dataContext = DatabaseFactory.Get()); }
		}

		public virtual void Add(T entity) {
			dbset.Add(entity);
		}

		public virtual void Update(T entity) {
			//dbset.Attach(entity);
			//dataContext.Entry(entity).State = EntityState.Modified;
			// OLL: Revisar este cambio de código. ¿Mejora o reduce la velocidad?
			T entityAttached = dbset.Local.FirstOrDefault(r => r.Equals(entity));
			if (entityAttached != null) {
				dataContext.Entry(entityAttached).CurrentValues.SetValues(entity);
			} else {
				dbset.Attach(entity);
				dataContext.Entry(entity).State = EntityState.Modified;
			}
		}

		public virtual void Delete(T entity) {
			dbset.Remove(entity);
		}

		public virtual void Delete(Expression<Func<T, bool>> where) {
			IEnumerable<T> objects = dbset.Where<T>(where).AsEnumerable();
			foreach (T obj in objects)
				dbset.Remove(obj);
		}

		public virtual T GetById(object id) {
			return dbset.Find(id);
		}

		//public virtual T GetById(long id) {
		//	return dbset.Find(id);
		//}

		//public virtual T GetById(string id) {
		//	return dbset.Find(id);
		//}

		public virtual T GetById(params object[] key) {
			return dbset.Find(key);
		}

		public virtual T GetById(string[] includes, Expression<Func<T, bool>> _predicate) {
			IQueryable<T> _set = dbset;
			foreach (string _include in includes) { _set = _set.Include(_include); }
			return _set.SingleOrDefault<T>(_predicate);
		}

		public virtual IEnumerable<T> GetAll() {
			return dbset.ToList();
		}

		public virtual int Count() {
			return dbset.Count();
		}

		public virtual int Count(Expression<Func<T, bool>> where) {
			return dbset.Where(where).Count();
		}

		public virtual IEnumerable<T> GetAll(string[] includes) {
			IQueryable<T> _set = dbset;
			foreach (string _include in includes) { _set = _set.Include(_include); }
			return _set.ToList();
		}

		public virtual IEnumerable<T> GetMany(Expression<Func<T, bool>> where) {
			return dbset.Where(where).ToList();
		}

		public virtual IEnumerable<T> GetMany(string[] includes, Expression<Func<T, bool>> where) {
			IQueryable<T> _set = dbset;
			foreach (string _include in includes) { _set = _set.Include(_include); }
			return _set.Where(where).ToList();
		}

		public virtual IEnumerable<T> GetQuery(string query, params object[] parameters) {
			return dataContext.Database.SqlQuery<T>(query, parameters);
		}

		public T Get(Expression<Func<T, bool>> where) {
			return dbset.Where(where).FirstOrDefault<T>();
		}

		public virtual bool Exist(Expression<Func<T, bool>> where) {
			return dbset.AsNoTracking().Any(where);
		}
	}
}
