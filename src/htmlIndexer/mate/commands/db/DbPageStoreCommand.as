package htmlIndexer.mate.commands.db
{

	import flash.events.Event;

	import htmlIndexer.mate.vos.PageVO;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;

	import nz.co.codec.flexorm.criteria.Criteria;

	public class DbPageStoreCommand extends DbCommand
	{

		// ----------------------------------------------------------------------
		// Public props
		// ----------------------------------------------------------------------

		public var page:PageVO;

		// ----------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------

		public function DbPageStoreCommand()
		{
			super();
		}

		// ----------------------------------------------------------------------
		// Public methods
		// ----------------------------------------------------------------------

		override public function execute(event:Event = null):void
		{
			super.execute(event);

			const criteria:Criteria =
					      dbManager.createCriteria(PageVO)
							      .addEqualsCondition('url', page.url);

			const result:ArrayCollection = dbManager.fetchCriteria(criteria);

			// Remove old pages with the same URL and their links at first…
			const cursor:IViewCursor = result.createCursor();
			while (!cursor.afterLast)
			{
				dbManager.remove(cursor.current);
				cursor.moveNext();
			}

			// …then save new page in DB.
			dbManager.save(page);
		}
	}
}